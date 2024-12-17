using QuadGK

big0 = BigFloat(0)
big1 = BigFloat(1)
#b
integral, error = quadgk(x -> 1 / (1 + 10 * x^2), big0, big1)
println("The integral is $integral and the error is $error")

#c
integral, error = quadgk(x -> (exp(-9 * x^2) + exp(-1024 * (x - 0.25)^2)) / sqrt(π), big0, big1)
println("The integral is $integral and the error is $error")

#d
integral, error = quadgk(x -> 50 / (2500 * π * x^2 + π), big0, big1 * 10)
println("The integral is $integral and the error is $error")