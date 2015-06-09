module ProbabilityAndStatistics
  #
  #
  #
  def ka_cube
    r = rand(1..21)
    if r <= 1
      1
    elsif r <= 3
      2
    elsif r <= 6
      3
    elsif r <= 10
      4
    elsif r <= 15
      5
    elsif r <= 21
      6
    end
  end

  #
  #
  #
  def kb_cube
    r = rand(1..21)
    if r <= 1
      6
    elsif r <= 3
      5
    elsif r <= 6
      4
    elsif r <= 10
      3
    elsif r <= 15
      2
    elsif r <= 21
      1
    end
  end

  #
  #
  #
  def choose_cube
    if rand(2) == 0
      method :ka_cube
    else
      method :kb_cube
    end
  end

  def choose_and_roll
    if rand(2) == 0
      ka_cube
    else
      kb_cube
    end
  end

  #
  #
  #
  def generate_histogram_data(&cube)
    # return  list of data
    (1..10000).each.map do |i|
      # return average
      (1..100)
          .map { cube.call }
          .compact
          .instance_eval { reduce(0) { |m, o| m += o }.to_f / length }
    end
  end
end