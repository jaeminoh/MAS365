using LinearAlgebra


# target function and jacobian. we'd like to solve f(x) = 0.

x0 = [1.0, 1.0, 1.0]

function f(x)
    out = Array{eltype(x)}(undef, 3)
    out[1] = 16x[1]^4 + 16x[2]^4 + x[3]^4 - 16
    out[2] = x[1]^2 + x[2]^2 + x[3]^2 - 3
    out[3] = x[1]^3 - x[2]
    return out
end

function jacobian(x)
    out = Array{eltype(x),2}(undef, 3, 3)
    out[1, 1] = 64x[1]^3
    out[1, 2] = 64x[2]^3
    out[1, 3] = 4x[3]^3
    out[2, 1] = 2x[1]
    out[2, 2] = 2x[2]
    out[2, 3] = 2x[3]
    out[3, 1] = 3x[1]^2
    out[3, 2] = -1
    out[3, 3] = 0
    return out
end

# Newton's method by hand.

function newton(x0, f, jacobian, tol=1e-6, max_iter=100)
    x = x0
    for i in 1:max_iter
        Δx = -jacobian(x) \ f(x)
        x += Δx
        if norm(Δx) < tol
            return x
        end
    end
    return x
end

x = newton(x0, f, jacobian)
println("Result: ", x)


# library routine

using NonlinearSolve, StaticArrays


u0 = @SVector[1.0, 1.0, 1.0]
prob = NonlinearProblem((u, p) -> f(u), u0)
sol = solve(prob, reltol=1e-15, abstol=1e-15)

println("Nonlinear solver from a library:", sol)

println("Comparison: ", sol.u - x) # up to 12 digits of accuracy.

function convergence_test(x0, f, jacobian, tol=1e-6, max_iter=100)
    x = x0
    ee = [norm(x0 - sol.u)]
    for i in 1:max_iter
        Δx = -jacobian(x) \ f(x)
        x += Δx
        push!(ee, norm(x - sol.u))
        if norm(Δx) < tol
            return ee
        end
    end
    return ee
end

using Plots
plot(convergence_test(x0, f, jacobian), yaxis=:log, label="Newton's method", xlabel="iteration", ylabel="error", dpi=300)
savefig("Final/2_convergence.png")