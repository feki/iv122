require_relative '../lib/turtle_graphics/turtle'

class LSystem
  def initialize(commands, rules, axiom)
    @commands = commands
    @rules = rules
    @axiom = axiom
  end

  # @param n_iteration [Fixnum]
  # @param turtle [Turtle]
  def draw(turtle, n_iteration)
    l_str = @axiom
    rex = Regexp.new "[#{@rules.keys.join}]"
    n_iteration.times do
      l_str = l_str.gsub(rex, @rules)
    end

    l_str.each_char do |c|
      @commands[c].call(turtle) if @commands.has_key?(c)
    end
  end
end