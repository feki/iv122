module ProbabilityAndStatistics
  #
  # Bayes
  #
  def bayes(prior, sequence)
    n = sequence.length

    # first dice probability
    p1 = (1.0/6) ** n

    # second dice probability
    # number five is replaced by number two
    dice_two = sequence.count { |s| s == 2 || s == 5 }
    p2 = ((2.0/6.0) ** dice_two) * ((1.0/6.0) ** (n - dice_two))

    # third dice probability
    dice_six = sequence.count(6)
    p3 = ((2.0/7.0) ** dice_six) * ((1.0/7.0) ** (n-dice_six))

    pdh=[p1,p2,p3]

    pd = 3.times.reduce(0) { |mem, i| mem += pdh[i] * prior[i] }
    3.times.each do |i|
      puts "#{i}. dice: #{(pdh[i] * prior[i])/pd}"
    end
  end
end

if $0 == __FILE__
  include ProbabilityAndStatistics

  bayes([1.0/3,1.0/3,1.0/3],[1, 3, 4, 5, 1, 4, 6, 5, 1, 5, 4, 5])
  bayes([0.05,0.05,0.9],[1, 3, 4, 5, 1, 4, 6, 5, 1, 5, 4, 5])
end
