require '../lib/turtle_graphics/turtle'

def shrub(turtle, len, angle, deep, ratio)
  return if deep.zero?

  turtle.forward(len)
  turtle.left(angle)
  shrub(turtle, len*ratio, angle, deep-1, ratio)
  turtle.right(2*angle)
  shrub(turtle, len*ratio, angle, deep-1, ratio)
  turtle.left(angle)
  turtle.pen_up
  turtle.back(len)
  turtle.pen_down
end

if __FILE__ == $0
  len = 120
  deep = 10
  angle = 45
  ratio = 0.59

  turtle = Turtle::Turtle.new(len*2.5, len*2.5, { :angle => 270, :x => 120*1.25, :y => len*2.5 -1 })

  shrub(turtle, len, angle, deep, ratio)

  turtle.write('outputs/turtle_shrub.svg')
end
