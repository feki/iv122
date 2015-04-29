require '../lib/turtle_graphics/turtle'
require '../06/fractals'

def pentaflake(turtle, n_iteration, step)
  commands = {
      '-' => lambda { |t| t.left(36) },
      '+' => lambda { |t| t.right(72) },
      'F' => lambda { |t| t.forward(step) },
      'R' => lambda { |t| t.left(180) },
  }
  rules = {
      'F' => 'F+F+FRF-F+F'
  }
  l = LSystem.new(commands, rules, 'F+F+F+F+F')
  draw_fractal(l,turtle, n_iteration)
end

if __FILE__ == $0

  turtle = Turtle::Turtle.new(100, 100, angle: 216)

  pentaflake(turtle, 4, 8)

  turtle.write('outputs/turtle_pentaflake.svg')
end
