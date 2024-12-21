using BandedMatrices, BlockBandedMatrices, SparseArrays, LinearAlgebra
using NonlinearSolve, StaticArrays

const n = 6

println("n: ", n, ", hence N: ", (n - 1)^2)

function make_A(n::Int)
    B = BandedMatrix(-1 => -1 * ones(n - 2), 0 => 4 * ones(n - 1), 1 => -1 * ones(n - 2)) |> collect
    eye = I(n - 1) |> collect
    A = BlockTridiagonal(fill(-eye, n - 2), fill(B, n - 1), fill(-eye, n - 2)) * n^2 |> sparse
    return A
end

function sgn(x::Number)::Int
    return x >= 0 ? 1 : -1
end

function tridiagonalization(A::AbstractMatrix)
    function householder_reflection(A::AbstractMatrix, i::Int)
        α = -sgn(A[i+1, i]) * norm(A[i+1:end, i])
        r = sqrt(0.5 * (α^2 - A[i+1, i] * α))
        v = zeros(size(A, 1))
        v[i+1] = (A[i+1, i] - α) / (2 * r)
        v[i+2:end] = A[i+2:end, i] / (2 * r)
        H = I - 2 * v * v'
        return H * A * H'
    end

    A = householder_reflection(A, 1)
    for i in 2:size(A, 1)-2
        A = householder_reflection(A, i)
    end

    return A
end

function principal_block(T::AbstractMatrix, block_position::Int)
    ii = (block_position-1)*(n-1)+1:block_position*(n-1)
    return T[ii, ii]
end

function divide_and_conquer(T)
    N = size(T, 1)
    k = N / 2 |> round |> Int
    β = T[k, k+1]
    @assert β ≈ T[k+1, k] "Matrix `T` is not symmetric!"
    u = zeros(N)
    u[k:k+1] .= 1

    T1 = T[begin:k, begin:k] |> Symmetric |> SymTridiagonal
    T2 = T[k+1:end, k+1:end] |> Symmetric |> SymTridiagonal

    λ1, Q1 = eigen(T1)
    λ2, Q2 = eigen(T2)

    d = cat(λ1, λ2, dims=1)
    v = cat(Q1[end, :], Q2[begin, :], dims=1)
    return β, d, v
end

A = make_A(n)
T = tridiagonalization(A)
β, d, v = divide_and_conquer(T)

function secular(λ; β=β, d=d, v=v)
    return 1 + β * sum(v .^ 2 ./ (d .- λ))
end

function find_eigs(secular, d)
    λ = []
    for i in eachindex(d)
        uspan = (d[i], d[i]+1)
        prob = NonlinearProblem((u, p) -> secular(u), uspan)
        sol = solve(prob, NewtonRaphson(), show_trace = Val(false), trace_level = TraceAll(1))
        push!(λ, sol.u)
    end
    return λ
end

println("Eigvals, found: ", find_eigs(secular, sort(d)[end-9:end]))


function exact_eigs(n::Int=6)
    λ = zeros(n-1, n-1)
    h = 1/n
    for i in 1:n-1
        for j in 1:n-1
            λ[i, j] = 4 / h^2 * (sin(0.5 * i * π * h)^2 + sin(0.5 * j * π * h)^2)
        end
    end
    return sort(λ[:])
end

println("Eigvals, exact: ", exact_eigs(n)[end-9:end])