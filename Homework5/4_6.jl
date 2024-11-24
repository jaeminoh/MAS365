using LinearAlgebra

"""
QR iteration.

Note that you have already implemented QR decomposition in the previous homework.
Use it to implement a QR iteration from the scratch.
"""
function QR_iteration(A::Matrix)
    while convergence_check(A) > 1e-10
        σ = A[end, end]
        q, r = qr(A - σ * I)
        A = r * q + σ * I
    end
    return A
end

"""
Resulting matrix of QR iteration must be almost (upper) triangulr.
This function returns the sum of subdiagonal entries of a matrix A.
"""
function convergence_check(A::Matrix)
    n = size(A)[1]
    off_diagonal = 0
    for i in 1:n
        off_diagonal += sum(abs.(A[i+1:end, i]))
    end
    return off_diagonal / sum(abs.(A))
end

"""
Test our custom implementation vs. a standard library routine on two small matrices.
Almost 14 digits of accuracy.
"""
function test()
    A = [2 3 2; 10 3 4; 3 6 1]
    D = QR_iteration(A)
    println("reference: ", eigvals(A), "; custom: ", diag(D))

    A = [6 2 1; 2 3 1; 1 1 1]
    D = QR_iteration(A)
    println("reference: ", eigvals(A), "; custom: ", diag(D))
end