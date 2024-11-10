using LinearAlgebra

A = [0.16 0.10; 0.17 0.11; 2.02 1.29]
b = [0.26; 0.28; 3.31]
x = A \ b

b̂ = [0.27; 0.25; 3.33]
x̂ = A \ b̂

println("solution to the original problem: ", x)
println("solution to the perturbed problem: ", x̂)

println("condition number of A^T A: ", cond(A' * A))