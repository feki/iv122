require '../lib/turtle_graphics/turtle'

def krishna_anklet(turtle, len, deep)
  return if deep.zero?

  krishna_anklet(turtle, len, deep-1)
  turtle.forward(len)
  krishna_anklet(turtle, len, deep-1)
  turtle.left(90)
  krishna_anklet(turtle, len, deep-1)
  turtle.forward(len)
  krishna_anklet(turtle, len, deep-1)
end

if __FILE__ == $0
  len = 3
  deep = 8

  turtle = Turtle::Turtle.new(1024, 1024, { :x => 1024, :y => 512, :angle => 90 })

  turtle.left(45)
  krishna_anklet(turtle, len, deep)
  turtle.left(90)
  krishna_anklet(turtle, len, deep)

  turtle.write('outputs/turtle_krishna_anklet.svg')
end
