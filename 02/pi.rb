class Pi
  # Gregory-Leibniz series
  def gls(number)
    (1..number).inject(4) { |pi, n| pi + gls_step(n) }
  end

  def gls_step(number)
    (((-1)**number) * (4.0/(2*number + 1)))
  end

  def gls_time(seconds)
    pi, n = 4, 1
    started_time = Time.now
    while true do
      pi += gls_step(n)
      n += 1
      elapsed_time = Time.now - started_time
      return {pi: pi, elapsed_time: elapsed_time} if seconds <= elapsed_time
    end
  end

  # Nilakantha series
  def ns(number)
    (1..number).inject(3) { |pi, n| pi + ns(n) }
  end

  def ns_step(number)
    (((-1)**(number+1)) * (4.0 / ((2*number)*(2*number+1)*(2*number+2))))
  end

  def ns_time(seconds)
    seconds = seconds.to_f
    pi, n = 3, 1
    started_time = Time.now
    while true do
      pi += ns_step(n)
      n += 1
      elapsed_time = Time.now - started_time
      return {pi: pi, elapsed_time: elapsed_time} if seconds <= elapsed_time
    end
  end

  # Archimedes method
  def as(number)
    a, b = 4, 2*Math.sqrt(2)
      
    while number > 2
      a = (2*a*b)/(a+b)
      b = Math.sqrt(a*b)

      number -= 1
    end

    [a, b]
  end

  def as_step(a, b)
    [(2*a*b)/(a+b), Math.sqrt((2*a*b*b)/(a+b))]
  end

  def as_time(seconds)
    seconds = seconds.to_f
    a, b, n = 4, 2*Math.sqrt(2), 1
    started_time = Time.now
    while true do
      a, b = as_step(a, b)
      n += 1
      elapsed_time = Time.now - started_time
      return {pi: (a + b) / 2.0, elapsed_time: elapsed_time} if seconds <= elapsed_time
    end
  end

  # Monte Carlo method
  def mcm(number)
    number_in_circle = number.times.count { |n| Math.hypot(rand, rand) <= 1.0 }
    4.0 * number_in_circle / number
  end

  def mcm_time(seconds)
    seconds = seconds.to_f
    number_in_circle, n = 0, 1
    started_time = Time.now
    while true do
      n += 1
      number_in_circle += 1 if Math.hypot(rand, rand) <= 1.0
      elapsed_time = Time.now - started_time
      return {pi: 4.0 * number_in_circle / n, elapsed_time: elapsed_time} if seconds <= elapsed_time
    end
  end
end
