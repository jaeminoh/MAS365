function underflow_level()
    ϵ = 1
    while ϵ/2 > 0
        ϵ /=  2
    end
    return ϵ
end

function overflow_level()
    infty = 1.0 # if integer, does not work.
    while !(infty * 2 == Inf)
        infty *= 2
    end
    return infty
end

function ϵ_machine()
    ϵ = 1
    while 1 + ϵ ≠ 1
        ϵ /= 2
    end
    return ϵ
end

function get_mantissa()
    nbits = 0
    ϵ = ϵ_machine() * 2
    while ϵ < 1
        ϵ *= 2
        nbits += 1
    end
    return nbits
end

function get_exponent()
    nbits = 0
    ∞ = log(2, overflow_level()) * 2 # overflow
    while ∞ > 1
        ∞ /= 2
        nbits += 1
    end
    return nbits
end


println("machine epsilon = $(ϵ_machine())")
println("overflow level = $(overflow_level())")
println("underflow_level = $(underflow_level())")
println("mantissa = $(get_mantissa())")
println("exponent = $(get_exponent())")
