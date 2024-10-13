using Plots, LaTeXStrings

xx = LinRange(0.995, 1.005, 101)

function f1(x)
    return (x-1)^(6.0)
end

function f2(x)
    return x^6 - 6*x^5 + 15 * x^4 - 20 * x^3 + 15 * x^2 - 6 * x + 1
end

ff1 = f1.(xx)
ff2 = f2.(xx)

plot(xx, ff1, label="compact form", lw=3.0)
plot!(xx, ff2, label="expanded form", linestyle=:dot, lw=3.0)
xaxis!(L"x")
yaxis!(L"f")
savefig("w1/1_14.pdf")
