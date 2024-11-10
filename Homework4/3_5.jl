using LinearAlgebra
using Plots

x = [1.02; 0.95; 0.87; 0.77; 0.67; 0.56; 0.44; 0.30; 0.16; 0.01]
y = [0.39; 0.32; 0.27; 0.22; 0.18; 0.15; 0.13; 0.12; 0.13; 0.15]

function solve(x, y)
    A = hcat(y.^2, x.*y, x, y, ones(size(x)))
    b = x.^2
    c = A \ b
    return c
end
c = solve(x, y)
println("original problem: ", c)

using Random
rng = Xoshiro(0)
x̂ = x .+ (rand(rng, Float64, size(x)) * 0.01 .- 0.005)
ŷ = y .+ (rand(rng, Float64, size(y)) * 0.01 .- 0.005)
ĉ = solve(x̂, ŷ)
println("perturbed problem: ", ĉ)

using ImplicitPlots
f(x,y, c) = c[1] * y^2 + c[2] * x * y + c[3] * x + c[4] * y + c[5] - x^2
implicit_plot((x,y)->f(x,y,c), dpi=300, label="original")
implicit_plot!((x,y)->f(x,y,ĉ), label="perturbed", linestyle=:dash, xlims=(-1.5, 2), ylims=(0,2))
scatter!(x, y, label=false)
savefig("figures/3-5.png")