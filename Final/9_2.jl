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

function f(t, u)
    return [- u[1] * u[2], (u[1] - 5) * u[2], 5u[2]]
end

u0 = [95, 5, 0] .|> Float64
t0 = 0.0
t1 = 1.0

tt, uu = RK4(f, u0, t0, t1, 10000, 100)

uu = stack(uu, dims=1)

plot(tt, uu[:, 1], label = "Susceptibles", xlabel = "Time", ylabel = "Population", title = "Epidemic model", lw = 2)
plot!(tt, uu[:, 2], label = "Infected", lw = 2)
plot!(tt, uu[:, 3], label = "Isolated", lw = 2)
savefig("Final/9_2.png")


function g(t, u; c::Number = 1e-2, d::Number = 1.0)
    return [- c * u[2] * u[1], (c * u[1] - d) * u[2], d*u[2]]
end
tt, uu = RK4(g, u0, t0, t1, 10000, 100)
uu = stack(uu, dims=1)
plot(tt, uu[:, 1], label = "Susceptibles", xlabel = "Time", ylabel = "Population", title = "Epidemic model", lw = 2)
plot!(tt, uu[:, 2], label = "Infected", lw = 2)
plot!(tt, uu[:, 3], label = "Isolated", lw = 2)
savefig("Final/9_2_not_grow.png")


tt, uu = RK4((t, u) -> g(t, u, c=1, d=1e-2), u0, t0, t1, 10000, 100)
uu = stack(uu, dims=1)
plot(tt, uu[:, 1], label = "Susceptibles", xlabel = "Time", ylabel = "Population", title = "Epidemic model", lw = 2)
plot!(tt, uu[:, 2], label = "Infected", lw = 2)
plot!(tt, uu[:, 3], label = "Isolated", lw = 2)
savefig("Final/9_2_wiped.png")