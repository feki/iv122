# Umocnovanie s realnym exponentom:
#   najskor rozdelime exponent na celu a realnu cast podla vzorca:
#   x**e = x**(a+b) = x**a * x**b, kde a je cela cast cisla e a b je realna cast e
#   realne cislo prevedieme do tvaru racionalneho cisla b = p/q kde p a q su cele cisla
#   x**b = x**(p/q) = qthroot(x**p)
class Exponentiation
  def squaring_pow(x, e)
    raise ArgumentError, 'Exponent must be integer.' if not e.is_a? Integer

    return 1 if e.zero?
    return squaring_pow(1.0/x, -e) if e < 0
    return x if e == 1

    e.odd? ? x * squaring_pow(x*x, (e-1)/2) : squaring_pow(x*x, e/2)
  end

  def pow(x, e)
    raise ArgumentError, 'Exponent must be integer.' if not e.is_a? Integer

    return pow(1.0/x, -e) if e < 0

    # irb(main):001:0> arr = Array.new(4, 9)
    # => [9, 9, 9, 9]
    # irb(main):002:0> arr.reduce(1, :*)    # 1 * 9 * 9 * 9 * 9
    # => 6561
    #
    # V podstate to iste ako:
    #
    # result = 1
    # for i in 1..e
    #   result *= x
    # end
    # return result
    Array.new(e, x).reduce(1, :*)
  end

  def nth_root(root, e, precision=0.000001)
    raise ArgumentError, 'Exponent must be integer.' if not e.is_a? Integer

    result = Float(e)
    begin
      prev = result
      result = ((root-1)*prev + e/squaring_pow(prev, root-1)) / root
    end while (prev - result).abs > precision
    result
  end

  # postupne redukuje desatinne miesta
  def pow_real(x, e, precision=000001)
    pow(x, e.to_i) * (e%1 != 0 ? nth_root(10, pow_real(x, (e%1)*10), precision) : 1)
  end

  # postupne redukuje desatinne miesta
  def squaring_pow_real(x, e, precision=000001)
    squaring_pow(x, e.to_i) * (e%1 != 0 ? nth_root(10, squaring_pow_real(x, (e%1)*10), precision) : 1)
  end
end