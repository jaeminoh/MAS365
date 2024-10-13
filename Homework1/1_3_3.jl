x = 1e-5

function series_t(x)
    return - (x^3 / 6 * (1 - x^2 / 20 * (1 - x^2 / 42 * (1 - x^2 / 72))))
end

println("Result.")
println("truncated series: ", series_t(x))
println("sin(x) - x: ", sin(x) - x)
println("Which one is more accurate?")
println("Let's see this by using a higher precision arithmetic.")
x_big = BigFloat(x)
println("BigFloat result: ", sin(x_big) - x_big)
println("Thus, tuncated series is more accurate.")
