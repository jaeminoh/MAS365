using NonlinearSolve, StaticArrays, LinearAlgebra

# (a)
println("   Problem (a)")

function a(u)
    out = @SVector[u[1] + u[2] * (u[2] * (5 - u[2]) - 2) - 13, u[1] + u[2] * (u[2] * (1 + u[2]) - 14) - 29]
    return out
end

function jacobian_a(u)
    out = @SMatrix[1 -3u[2]^2+10u[2]-2; 1 3u[2]^2+2u[2]-14]
    return out
end

u0 = @SVector[15, -2]
prob = NonlinearProblem((u, p) -> a(u), u0)
sol = solve(prob, NewtonRaphson(concrete_jac=jacobian_a), show_trace = Val(true), trace_level = TraceAll(1))

println("Solution: ", sol.u)
println("Residual: ", sol.resid)

# (b)
println("\n    Problem (b)")

function b(u)
    out = @SVector[sum(u.^2)-5, u[1] + u[2] - 1, u[1] + u[3] - 3]
    return out
end

function jacobian_b(u)
    out = @SMatrix[2u[1] 2u[2] 2u[3]; 1 1 0; 1 0 1]
    return out
end

u0 = @SVector[(1 + sqrt(3)) / 2, (1 - sqrt(3)) / 2, sqrt(3)]
prob = NonlinearProblem((u, p) -> b(u), u0)
sol = solve(prob, NewtonRaphson(concrete_jac=jacobian_b), show_trace = Val(true), trace_level = TraceAll(1))

println("Solution: ", sol.u)
println("Residual: ", sol.resid) # poor residual for x₃. Why?




println("Condition number of the Jacobian matrix at x₀: ", cond(jacobian_b(u0)))


# (e)
println("\n    Problem (e)")

function e(u)
    out = @SVector[1e4 * u[1] * u[2] - 1e-4, exp(-u[1]) + exp(-u[2]) - 1 - 1e-4]
    return out
end

u0 = @SVector[0, 1]
prob = NonlinearProblem((u, p) -> e(u), u0)
sol = solve(prob, NewtonRaphson(), show_trace = Val(true), trace_level = TraceAll(1))

println("Solution: ", sol.u)
println("Residual: ", sol.resid) # poor residual for x₃. Why?
