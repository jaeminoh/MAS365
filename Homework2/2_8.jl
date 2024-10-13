using LinearAlgebra
using Random
LinearAlgebra.NoPivot

rng = Xoshiro(0)
n = 100
A = rand(rng, Float64, (n, n))
x = ones(n)
b = A * x

println("reference error level: ", norm(A \ b - x) / norm(x))

D = diagm(exp10.(-n/2:n/2-1))
x̂ = (D * A) \ (D * b)

println("condition number of D * A: ", cond(D * A))

res = norm((D * A) * x̂ - (D * b)) / (norm(x̂) * opnorm(D * A))
err = norm(x̂ - x) / norm(x)

println("relative residual: ", res)
println("relative error: ", err)
