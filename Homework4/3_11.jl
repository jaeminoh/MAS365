using LinearAlgebra: norm, I

function qr(A)
    m, n = size(A)
    vv = []
    for j in 1:n
        a_j = A[:, j]
        a_j[1:j-1] .= 0


        α_j = -sign(a_j[j]) * norm(a_j)

        e_j = zeros(m)
        e_j[j] += 1


        v_j = a_j - α_j * e_j

        β_j = v_j' * v_j

        push!(vv, v_j)

        if β_j ≠ 0
            for k in j:n
                γ_k = v_j' * A[:, k]
                A[:, k] .= A[:, k] .- (2 * γ_k / β_j) .* v_j
            end
        end
    end
    return vv, A
end

A = rand(Float64, (32, 16))
vv, R = qr(A) # Householder vectors, and R.

function reflection(v)
    return I - 2 * v * v' / (v' * v)
end

HH = [reflection(v) for v in vv]

function Q_from_H(HH)
    Q = I
    for i in length(HH):1
        Q *= HH[i]
    end
    return Q
end
Q = Q_from_H(HH)
println("sum of subdiagonal entries of R: ", sum([ sum(R[j+1:end,j]) for j in 1:size(A)[2]] ))
println("QR = A check: ", Q * R ≈ A)


