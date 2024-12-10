function evaluate_at(t, tt, coeffs)
    result = coeffs[end]
    for i in length(coeffs)-1:-1:1
        result = result * (t - tt[i]) + coeffs[i]
    end
    return result
end

function _add_point(tt, coeffs, t, y)
    new_coef = (y - evaluate_at(t, tt, coeffs)) / prod(t .- tt)
    append!(coeffs, new_coef)
    append!(tt, t)
    return tt, coeffs
end

function newton_interpolant(tt, yy)
    coeffs = [yy[begin]]
    for i in 2:1:length(tt)
        _, coeffs = _add_point(tt[begin:i-1], coeffs[begin:i-1], tt[i], yy[i])
    end
    return tt, coeffs
end

tt = [-2, 0, 1] .|> Float64
yy = [-27, -1, 0] .|> Float64

tt, coeffs = newton_interpolant(tt, yy)
println(coeffs)