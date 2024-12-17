using QuadGK

integral, error = quadgk(x -> cos(x), -1, 1)
println("Integral: ", integral, " Error: ", error)
integral, error = quadgk(x -> 1 / (1 + 100 * x^2), -1, 1)
println("Integral: ", integral, " Error: ", error)

# draw plot with this file.
open("Homework8/8_3.txt", "w") do f
    quadgk_print(f, x -> sqrt(abs(x)), -1, 1)
end
