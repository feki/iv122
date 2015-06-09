require_relative 'monty_hall'

if $0 == __FILE__
  include ProbabilityAndStatistics

  monty = MontyHall.new
  (3..6).each do |i|
    n = 10 ** i

    puts "n = #{n}\n\n"

    success = monty.simulate_game(n, :stay_decision)
    printf "  Stay: %7d / %-7d = %f %%\n", success, n, success / n * 100

    success = monty.simulate_game(n, :smart_decision)
    printf " Smart: %7d / %-7d = %f %%\n", success, n, success / n * 100

    success = monty.simulate_game(n, :random_decision)
    printf "Random: %7d / %-7d = %f %%\n\n", success, n, success / n * 100
  end
end