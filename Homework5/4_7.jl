using LinearAlgebra, Random

"""
Lanczos Iteration (Algorithm 4. 10).
"""
function Lanczos_custom(A::Matrix; m::Int=20, seed::Int=0)
    @assert A ≈ A'

    n = size(A)[1]
    αα = Vector{Float64}()
    ββ = Vector{Float64}()
    β₀ = 0
    x₀ = rand(Xoshiro(seed), Float64, n)
    q₀ = zeros(n)
    q₁ = x₀ / norm(x₀)

    for _ in 1:m
        u = A * q₁
        α = q₁' * u
        u -= (β₀ * q₀ + α * q₁)
        β₁ = norm(u)

        push!(αα, α)
        push!(ββ, β₁)
        if β₁ ≈ 0
            break
        end
        q₀ = q₁
        q₁ = u / β₁
        β₀ = β₁

    end
    aa = αα
    bb = ββ[2:end]

    T = Tridiagonal(bb, aa, bb) 
    @assert T ≈ T'

    return eigvals(T) # return Ritz values
end

"""
Test for (n x n) real symmetric matrix
"""
function test(n::Int=20, seed::Int=0)
    rng = Xoshiro(seed)
    B = rand(rng, Float64, (n, n))
    q, _ = qr(B)
    D = diagm(1:1:n)
    A = q * D * q'
    λ = Lanczos_custom(D, m=n, seed=seed)
    println("result for n=$(n): ", λ)
end
