using Plots, LaTeXStrings

function get_c_error(n::Int)
    c_true = ones(n+1)
    A = zeros(n+1, n+1)
    for i in 1:n+1
        for j in 1:n+1
            A[i,j] = 1 / (i + j + 1)
        end
    end
    f = sum(A, dims=1)'
    c_pred = (A \ f)[:,1]
    err = maximum(abs.(c_pred[:,1] - c_true)) / maximum(abs.(c_true))
    return err
end

nn = 1:100
ee = get_c_error.(nn)
plot(nn, ee, yaxis=:log10, legend=false, dpi=300)
xaxis!(L"n")
yaxis!(L"L_∞")
savefig("w2/2_3_13.pdf")
