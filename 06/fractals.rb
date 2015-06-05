require_relative 'l_system'

def sierpinski_triangle(step = 10)
  commands = {
      '-' => lambda { |t| t.left(60) },
      '+' => lambda { |t| t.right(60) },
      'A' => lambda { |t| t.forward(step) },
      'B' => lambda { |t| t.forward(step) }
  }
  rules = {
      'A' => 'B-A-B',
      'B' => 'A+B+A'
  }
  l = LSystem.new(commands, rules, 'A')
end

def hilbert_curve(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'A' => '-BF+AFA+FB-',
      'B' => '+AF-BFB-FA+'
  }
  l = LSystem.new(commands, rules, 'A')
end

def koch_snowflake(step = 10)
  commands = {
      '-' => lambda { |t| t.left(60) },
      '+' => lambda { |t| t.right(60) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'F-F++F-F'
  }
  l = LSystem.new(commands, rules, 'F++F++F')
end

def draw_fractal(l_system, turtle, n_iteration)
  l_system.draw(turtle, n_iteration)
end

if $0 == __FILE__
  turtle = Turtle::Turtle.new(1024, 1024)
  draw_fractal(sierpinski_triangle, turtle, 10)
  turtle.write('outputs/sierpinski_triangle.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(hilbert_curve, turtle, 5)
  # turtle.write('outputs/hilbert_curve.svg')
  #
  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_snowflake, turtle, 4)
  # turtle.write('outputs/koch_snowflake.svg')
end