class Exponentiation
  def squaring_pow(x, e)
    return 1 if e.zero?
    return x if e == 1

    e.odd? ? x * squaring_pow(x*x, (e-1)/2) : squaring_pow(x*x, e/2)
  end

  def pow(x, e)
    return (x ** (e-e.to_int)) * pow(x, e.to_int) if e.is_a? Float

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

  def nthroot(n, x, precision=0.000001)
    a = Float(x)
    begin
      prev = a
      a = ((n-1)*prev + x/squaring_pow(prev,n-1)) / n
    end while (prev - a).abs > precision
    a
  end

  def ln(x1, n=100)
    x = x1-1
    (1..n).inject(0) { |mem, i| mem += squaring_pow(-1, i+1)*(squaring_pow(x, i)/Float(i)) }
  end

  def pow_real(x, e)

  end
end