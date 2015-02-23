class Gcd
  class << self
    def gcd_subtract(a, b)
      raise "a and b must be greater than 0" if a <= 0 or b <= 0

      while a != b
        a, b = b, a if a < b
        a = a - b
        yield if block_given?
      end

      a
    end

    def gcd_modulo(a, b)
      raise "a and b must be greater than 0" if a <= 0 or b <= 0
      a, b = b, a if a < b

      while a % b != 0
        a, b = b, a % b
        yield if block_given?
      end

      b
    end

    def gcd_subtract_steps(a, b)
      res = 0
      Gcd.gcd_subtract(a, b) { res += 1 }
      res
    end

    def gcd_modulo_steps(a, b)
      res = 0
      Gcd.gcd_modulo(a, b) { res += 1 }
      res
    end
  end
end
