require '../lib/turtle_graphics/turtle'
require '../06/fractals'

def dragon_curve(turtle, n_iteration, step)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'X' => 'X+YF+',
      'Y' => '-FX-Y'
  }
  l = LSystem.new(commands, rules, 'FX')
  draw_fractal(l,turtle, n_iteration)
end

if __FILE__ == $0

  turtle = Turtle::Turtle.new(100, 100)

  dragon_curve(turtle, 11, 10)

  turtle.write('outputs/turtle_dragon_curve.svg')
end
