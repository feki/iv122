require '../lib/turtle_graphics/turtle'

def koch(turtle, len, deep)
  if deep <= 0
    turtle.forward(len)
  else
    len3 = len/3.0
    koch(turtle, len3, deep-1)
    turtle.left(60)
    koch(turtle, len3, deep-1)
    turtle.right(120)
    koch(turtle, len3, deep-1)
    turtle.left(60)
    koch(turtle, len3, deep-1)
  end
end

if __FILE__ == $0
  n = 3
  a = 240
  deep = 7
  angle = 360/n

  alfa = 2*Math::PI/n
  r = a/(2*Math.sin(alfa/2))

  size, cx, cy = 2*(r+20), r+20, r+20

  turtle = Turtle::Turtle.new(size, size, { :x => cx, :y => cy-r, :angle => 90+(180-angle)/2 })

  n.times { koch(turtle, a, deep); turtle.right(angle); }

  turtle.write('outputs/turtle_koch_snowflake.svg')
end
