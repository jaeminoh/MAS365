using LinearAlgebra, SparseArrays, BandedMatrices

n = 3000

function dense_A(n::Int)
    A = zeros(Float64, (n, n))
    for j in 1:n
        for i in 1:n
            if abs(i-j) == 2
                A[i,j] = 1
            elseif abs(i-j) == 1
                A[i,j] = -4
            elseif i==j
                A[i,j] = 6
            end
        end
    end
    A[1,1] = 9
    A[end, end] = 1
    A[end-1, end-1] = 5
    A[end-1, end] = -2
    A[end, end-1] = -2
    return A
end

function return_b(n::Int)
    return ones(n) / n^4
end

A = dense_A(n)
b = return_b(n)


x_dense = A \ b;

A_sp = sparse(A)
x_sp = A_sp \ b;

A_band = BandedMatrix(A_sp)
println("Condition number of A: ", cond(A_band))
x_band = A_band \ b;


# check
println("x_dense = x_sp? ", x_dense ≈ x_sp)
println("x_dense = x_band? ", x_dense ≈ x_band)
println("x_sp = x_band? ", x_sp ≈ x_band)

println("computing time for x:", @elapsed A \ b)
println("computing time for x_sp:", @elapsed A_sp \ b)
println("computing time for x_band:", @elapsed A_band \ b)


function return_R(n::Int)
    R = BandedMatrix((0=>ones(n), 1=>-2*ones(n-1), 2=>ones(n-2)), (n,n))
    R[1,1] = 2
    return R
end

R = return_R(n)
println("A = RR'? ", A ≈ R * R')

x = R' \ (R \ b)

println("relative error: ", norm(x_band - x) / norm(x))

function solve_with_R(n::Int)
    R = return_R(n)
    b = return_b(n)
    return R' \ (R \ b)
end

function solve_with_A(n::Int)
    A = BandedMatrix((0=>6*ones(n), 1=>-4*ones(n-1), 2=>ones(n-2)), (n,n))
    A[1,1] = 9
    A[end,end] = 1
    A[end-1,end-1] = 5
    A[end-1, end] = -2
    A = Symmetric(A)
    b = return_b(n)
    return A \ b
end

r = b - A * x_dense
x_dense += A \ r
r = b - A * x_dense
x_dense += A \ r
println("after two-step refinement: ", norm(x_dense - x) / norm(x))
