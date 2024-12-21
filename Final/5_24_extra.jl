using NonlinearSolve, StaticArrays

function f(u)
    w = u[begin:3]
    x = u[4:end]
    out = @SVector[sum(w) - 2, sum(w .* x), sum(w .* x.^2) - 2 / 3, sum(w .* x.^3), sum(w .* x.^4) - 2 / 5, sum(w.*x.^5)]
    return out
end

u0 = @SVector[2/3, 2/3, 2/3, 0, -1, 1]
prob = NonlinearProblem((u, p) -> f(u), u0)
sol = solve(prob)
println("w: ", sol.u[begin:3])
println("x: ", sol.u[4:end])

