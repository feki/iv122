module ProbabilityAndStatistics
  #
  #
  #
  class MontyHall
    #
    # It represent smart decision.
    #
    def smart_decision(guess, shown)
      ([0,1,2] - [guess,shown]).first
    end
    
    #
    # It represent same decision.
    #
    def stay_decision(guess, shown)
      guess
    end

    #
    # It represent random decision.
    #
    def random_decision(guess, shown)
      ([0,1,2] - [shown])[rand(2)]
    end

    #
    # It simulates Monty Hall problem game and runs game n times.
    # It returns number of successes.
    #
    def simulate_game(n, strategy)
      success = 0.0

      n.times do
        doors = [ :nothing, :nothing, :treasure ].shuffle
        guess = rand(3)
        begin
          shown = rand(3)
        end while shown == guess || doors[shown] == :treasure

        decision = self.send(strategy, guess, shown)

        if doors[decision] == :treasure
          success += 1
        end
      end

      success
    end
  end
end