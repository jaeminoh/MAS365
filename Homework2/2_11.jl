using Random, LinearAlgebra

function WithoutPivot(A, b)
    n = size(A)[1]
    x = zeros(n)

    for i in 1:n-1
        m = -A[i+1:n, i] / A[i, i]
        A[i+1:n, :] += m * transpose(A[i, :])
        b[i+1:n] += m * b[i]
    end

    x[n] = b[n] / A[n, n]

    for i in n-1:-1:1
        x[i] = (b[i] - transpose(A[i, i+1:n]) * x[i+1:n]) / A[i, i]
    end

    return x
end


function get_max_row(A, i)
    n = size(A)[1]
    max_row = i
    for k in i:n-1
        if abs(A[k,i]) > abs(A[max_row, i])
            max_row = k
        end
    end
    return max_row
end

function PartialPivot(A, b)
    n = size(A)[1]
    x = zeros(n)

    for i in 1:n-1
        max_row = get_max_row(A, i)
        A[i,:], A[max_row,:] = A[max_row,:], A[i,:]
        b[i], b[max_row] = b[max_row], b[i]
        m = -A[i+1:n, i] / A[i, i]
        A[i+1:n, :] += m * transpose(A[i, :])
        b[i+1:n] += m * b[i]
    end

    x[n] = b[n] / A[n, n]

    for i in n-1:-1:1
        x[i] = (b[i] - transpose(A[i, i+1:n]) * x[i+1:n]) / A[i, i]
    end

    return x

end

A = rand(Float64, (100, 100))
x = rand(Float64, 100)
b = A * x

x̂ = WithoutPivot(A, b)
x̂1 = PartialPivot(A, b)

println("Without Pivot: ", norm(x - x̂) / norm(x))
println("Partial Pivot: ", norm(x - x̂1) / norm(x))
println("LU: ", norm(x - A \ b) / norm(x))

t0 = @elapsed WithoutPivot(A, b)
t1 = @elapsed PartialPivot(A, b)
println("Computing time, w/o, partial: ", t0, t1)
