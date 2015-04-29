require '../lib/turtle_graphics/turtle'
require_relative 'turtle_regular_polygon'
require_relative 'turtle_star_polygon'

def picture_A(turtle, len_a=45)
  turtle_regular_polygon(turtle, 5, len_a)
  turtle.left(36)
  turtle_star_polygon(turtle, 5, 2, len_a)
end

def picture_B(turtle, len_a, shift, depth)
  len = len_a
  angle = Math.atan((len*shift)/(len*(1-shift)))
  depth.times do
    turtle_regular_polygon(turtle, 4, len)

    turtle.pen_up
    turtle.forward(len*shift)
    turtle.pen_down
    turtle.left((180/Math::PI)*angle)

    len = Math.hypot(len*shift, len*(1-shift))
  end
end

def picture_C
  # TODO:
end

def picture_D(turtle, len_a, shift)
  len = len_a
  while len-shift > 0
    turtle_regular_polygon(turtle, 3, len)

    turtle.position[1] += shift
    nt = Math.sqrt(len**2 - (len/2.0)**2) - 1.5*shift
    len = Math.sqrt(4*nt**2/3)
  end
end

def picture_E(turtle, m, n, len_a)
  m.times do
    turtle_regular_polygon(turtle, n, len_a)
    turtle.right(360.0/m)
  end
end

if __FILE__ == $0
  turtle = Turtle::Turtle.new(100, 100, angle: 36)
  picture_A(turtle)
  turtle.write('outputs/pictureA.svg')

  size = 1024
  turtle = Turtle::Turtle.new(size, size, { :x => 20, :y => 20, :angle => 90 })
  picture_B(turtle, size-40, 0.2, 56)
  turtle.write('outputs/pictureB.svg')

  len_a = 250
  alfa = 2*Math::PI/3
  r = len_a/(2*Math.sin(alfa/2))
  size, cx, cy = 2*(r+20), r+20, r+20
  turtle = Turtle::Turtle.new(size, size, { :x => cx, :y => cy-r, :angle => 90-(180-120)/2 })
  picture_D(turtle, len_a, 5)
  turtle.write('outputs/pictureD.svg')

  len_a = 30
  n = 16
  alfa = 2*Math::PI/n
  r = len_a/(2*Math.sin(alfa/2))
  size, cx, cy = 2*(r+20), r+20, r+20
  turtle = Turtle::Turtle.new(2*(size+20), 2*(size+20), { :x => 20+size, :y => 20+size, :angle => 90 })
  picture_E(turtle, n, n, len_a)
  turtle.write('outputs/pictureE.svg')
end
