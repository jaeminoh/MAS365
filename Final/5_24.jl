using NonlinearSolve, StaticArrays, LinearAlgebra

function f(x)
    out = @SVector[x[1] + x[2] - 2, x[1] * x[3] + x[2] * x[4], x[1] * x[3]^2 + x[2] * x[4]^2 - 2 / 3, x[1] * x[3]^3 + x[2] * x[4]^3]
    return out
end


u0 = @SVector[4, -2, -0.01, 0.01]
prob = NonlinearProblem((u, p) -> f(u), u0)
sol = solve(prob)
println(sol.u)

