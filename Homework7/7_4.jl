using Interpolations
using Plots
using Polynomials

# Define the data points
n = 11
xx = LinRange(-1, 1, n)
f(x) = 1 / (1 + 25 * x^2)
ff = f.(xx)

# Create a cubic spline interpolation
function create_cubic_spline_interpolation(xx, ff)
    itp = interpolate(ff, BSpline(Cubic(Line(OnGrid()))))
    sitp = scale(itp, xx)
    return sitp
end

# Create a polynomial interpolant
function create_polynomial_interpolant(xx, ff)
    p = fit(xx, ff, length(xx)-1)
    return p
end

# Evaluate the interpolations at new points
xx_new = -1:0.01:1
sitp = create_cubic_spline_interpolation(xx, ff)
cubic = sitp.(xx_new)

p = create_polynomial_interpolant(xx, ff)
pp = p.(xx_new)

# Plot the original function, polynomial interpolant, and cubic spline interpolation
plot(xx_new, f, label="f")
plot!(xx_new, pp, label="poly")
plot!(xx_new, cubic, label="cubic")
title!("Runge effect")

# Save the plot
savefig("figures/7-4.png")