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

def koch_island(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'F+FF-FF-F-F+F+FF-F-F+F+FF+FF-F'
  }
  l = LSystem.new(commands, rules, 'F-F-F-F')
end

def koch_curve(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'F+F-F-F+F'
  }
  l = LSystem.new(commands, rules, '-F')
end

def koch_curve2(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
      'f' => lambda { |t| t.pen_up; t.forward(step); t.pen_down }
  }
  rules = {
      'F' => 'F+f-FF+F+FF+Ff+FF-f+FF-F-FF-Ff-FFF',
      'f' => 'ffffff'
  }
  l = LSystem.new(commands, rules, 'F+F+F+F')
end

def koch_curve3(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'FF-F-F-F-F-F+F'
  }
  l = LSystem.new(commands, rules, 'F-F-F-F')
end

def koch_curve4(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'FF-F-F-F-FF'
  }
  l = LSystem.new(commands, rules, 'F-F-F-F')
end

def koch_curve5(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'FF-F+F-F-FF'
  }
  l = LSystem.new(commands, rules, 'F-F-F-F')
end

def koch_curve6(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'FF-F--F-F'
  }
  l = LSystem.new(commands, rules, 'F-F-F-F')
end

def koch_curve7(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'F-FF--F-F'
  }
  l = LSystem.new(commands, rules, 'F-F-F-F')
end

def koch_curve8(step = 10)
  commands = {
      '-' => lambda { |t| t.left(90) },
      '+' => lambda { |t| t.right(90) },
      'F' => lambda { |t| t.forward(step) },
  }
  rules = {
      'F' => 'F-F+F-F-F'
  }
  l = LSystem.new(commands, rules, 'F-F-F-F')
end

def branch1(step = 10)
  commands = {
      '-' => lambda { |t| t.left(25.7) },
      '+' => lambda { |t| t.right(25.7) },
      'F' => lambda { |t| t.forward(step) },
      '[' => lambda { |t| t.push_state },
      ']' => lambda { |t| t.pop_state },
  }
  rules = {
      'F' => 'F[+F]F[-F]F'
  }
  l = LSystem.new(commands, rules, 'F')
end

def branch2(step = 10)
  commands = {
      '-' => lambda { |t| t.left(20) },
      '+' => lambda { |t| t.right(20) },
      'F' => lambda { |t| t.forward(step) },
      '[' => lambda { |t| t.push_state },
      ']' => lambda { |t| t.pop_state },
  }
  rules = {
      'F' => 'F[+F]F[-F]F'
  }
  l = LSystem.new(commands, rules, 'F')
end

def branch3(step = 10)
  commands = {
      '-' => lambda { |t| t.left(22.5) },
      '+' => lambda { |t| t.right(22.5) },
      'F' => lambda { |t| t.forward(step) },
      '[' => lambda { |t| t.push_state },
      ']' => lambda { |t| t.pop_state },
  }
  rules = {
      'F' => 'FF-[-F+F+F]+[+F-F-F]'
  }
  l = LSystem.new(commands, rules, 'F')
end

def draw_fractal(l_system, turtle, n_iteration)
  l_system.draw(turtle, n_iteration)
end

if $0 == __FILE__
  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(sierpinski_triangle, turtle, 5)
  # turtle.write('outputs/sierpinski_triangle.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(hilbert_curve, turtle, 5)
  # turtle.write('outputs/hilbert_curve.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_snowflake, turtle, 4)
  # turtle.write('outputs/koch_snowflake.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_island, turtle, 3)
  # turtle.write('outputs/koch_island.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_curve, turtle, 4)
  # turtle.write('outputs/koch_curve.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_curve2, turtle, 2)
  # turtle.write('outputs/koch_curve2.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_curve3, turtle, 4)
  # turtle.write('outputs/koch_curve3.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_curve4, turtle, 4)
  # turtle.write('outputs/koch_curve4.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_curve5, turtle, 4)
  # turtle.write('outputs/koch_curve5.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_curve6, turtle, 4)
  # turtle.write('outputs/koch_curve6.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_curve7, turtle, 5)
  # turtle.write('outputs/koch_curve7.svg')

  # turtle = Turtle::Turtle.new(1024, 1024)
  # draw_fractal(koch_curve8, turtle, 5)
  # turtle.write('outputs/koch_curve8.svg')

  # turtle = Turtle::Turtle.new(1024, 1024, angle: 270)
  # draw_fractal(branch1, turtle, 5)
  # turtle.write('outputs/branch1.svg')

  # turtle = Turtle::Turtle.new(1024, 1024, angle: 270)
  # draw_fractal(branch2, turtle, 5)
  # turtle.write('outputs/branch2.svg')

  turtle = Turtle::Turtle.new(1024, 1024, angle: 270)
  draw_fractal(branch3, turtle, 5)
  turtle.write('outputs/branch3.svg')
end