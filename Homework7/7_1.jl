function _horner(coeffs::Vector{T}, x::T) where {T<:Number}
    result = coeffs[end]
    for i in length(coeffs)-1:-1:1
        result = result * x + coeffs[i]
    end
    return result
end

function evaluate_at(x::T, coeffs::Vector{T}) where {T<:Number}
    return _horner(coeffs, x)
end

function differentiate_at(x::T, coeffs::Vector{T}) where {T<:Number}
    coeffs = coeffs[2:end]
    coeffs = coeffs.*collect(1:1:length(coeffs))
    return _horner(coeffs, x)
end

function integrate_on(a::T, b::T, coeffs::Vector{T}) where {T<:Number}
    coeffs = coeffs ./ collect(1:1:length(coeffs))
    prepend!(coeffs, 0)
    return _horner(coeffs, b) - _horner(coeffs, a)
end