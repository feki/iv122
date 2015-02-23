class Collatz
  def initialize(number)
    @number = number
  end
  
  def sequence
    @_sequence ||= Collatz.collatz_sequence(@number)
  end

  def number_of_steps
    sequence.count
  end

  def maximum_number
    sequence.max
  end

  class << self
    def collatz_sequence(number)
      return [number] if number == 1

      next_number = number.even? ? number/2 : number*3 + 1
      [number].concat collatz_sequence(next_number)
    end
  end
end
