using Plots, LaTeXStrings

nn = 1:1:10

function stirling(n::Int)
    return sqrt(2 * π * n) * (n / ℯ)^n
end

True = factorial.(nn)
Pred = stirling.(nn)


abs_err = @. abs(Pred - True)
rel_err = abs_err ./ True

plot(nn, abs_err, label="absolute error", yaxis=:log10, lw=3.0)
plot!(nn, rel_err, label="relative_error", lw=3.0, linestyle=:dot)
xaxis!(L"n")
yaxis!(L"ε")
savefig("w1/1_1.pdf")
