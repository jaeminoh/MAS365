using Plots

function RK4(f, u0, t0, t1, num_steps::Int, save_every::Int = 10)
    h = (t1 - t0) / num_steps
    t = t0
    tt = [t0]
    u = u0
    uu = [u0]
    for _ in 1:num_steps
        k1 = h * f(t, u)
        k2 = h * f(t + h/2, u + k1/2)
        k3 = h * f(t + h/2, u + k2/2)
        k4 = h * f(t + h, u + k3)
        u += (k1 + 2k2 + 2k3 + k4) / 6
        t += h
        if num_steps % save_every == 0
            push!(tt, t)
            push!(uu, u)
        end
    end
    return tt, uu
end

function predator_prey(t, u)
    return [u[1] * (1 - 0.1u[2]), u[2] * (-0.5 + 0.02u[1])]
end

u0 = [100.0, 10.0]
t0 = 0.0
t1 = 25.0

tt, uu = RK4(predator_prey, u0, t0, t1, 50000, 1000)
uu = stack(uu, dims=1)
plot(tt, uu[:, 1], label = "Prey", xlabel = "Time", ylabel = "Population", title = "Prey-Predator Model", lw = 2)
plot!(tt, uu[:, 2], label = "Predator", lw = 2)
savefig("Final/9_1_time.png")

scatter(uu[:, 1], uu[:, 2], xlabel = "Prey", ylabel = "Predator", title = "Prey-Predator Model", label = "Phase Plot", markersize=1, linestyle=:dot)
savefig("Final/9_1_phase.png")

u0 = [1.0, 100.0]
tt, uu = RK4(predator_prey, u0, t0, t1, 50000, 1000)
uu = stack(uu, dims=1)
plot(tt, uu[:, 1], label = "Prey", xlabel = "Time", ylabel = "Population", title = "Prey-Predator Model", lw = 2)
plot!(tt, uu[:, 2], label = "Predator", lw = 2)
savefig("Final/9_1_extinction.png")

# stationary points
u_st = [25.0, 10.0]

tt, uu = RK4(predator_prey, u_st, t0, t1, 50000, 100)
uu = stack(uu, dims=1)
plot(tt, uu[:, 1], label = "Prey", xlabel = "Time", ylabel = "Population", title = "Prey-Predator Model", lw = 2)
plot!(tt, uu[:, 2], label = "Predator", lw = 2)
savefig("Final/9_1_st.png")


function gower(t, u)
    return [u[1] * (1 - 0.1u[2]), u[2] * (0.5 - 10u[2] / u[1])]
end

u0 = [10.0, 100.0]
tt, uu = RK4(gower, u0, t0, t1, 50000, 1000)
uu = stack(uu, dims=1)
plot(tt, uu[:, 1], label = "Prey", xlabel = "Time", ylabel = "Population", title = "Gower Model", lw = 2)
plot!(tt, uu[:, 2], label = "Predator", lw = 2)
savefig("Final/9_1_gower.png")