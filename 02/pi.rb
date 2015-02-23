class Pi
  # Gregory-Leibniz series
  def gls(number)
    (1..number).inject(4) { |pi, n| pi + (((-1)**n) * (4.0/(2*n + 1))) }
  end

  # Nilakantha series
  def ns(number)
    (1..number).inject(3) { |pi, n| pi + (((-1)**(n+1)) * (4.0 / ((2*n)*(2*n+1)*(2*n+2)))) }
  end

  # Archimedes series
  def as(number)
    a, b = 2*Math.sqrt(2), 4
      
    while number > 2
      b = (2*a*b)/(a+b)
      a = Math.sqrt(a*b)

      number -= 1
    end

    [a, b]
  end

  # Monte Carlo method
  def mcm(number)
    number_in_circle = number.times.count { |n| Math.hypot(rand, rand) <= 1.0 }
    4.0 * number_in_circle / number
  end
end
