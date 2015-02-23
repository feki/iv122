require '../lib/turtle_graphics/turtle'

def sierpinski(turtle, len, deep)
  if deep <= 0
    turtle.forward(len)
  else
    len2 = len/2.0

    turtle.forward(len2)
    turtle.left(120)
    3.times do
      sierpinski(turtle, len2, deep-1)
      turtle.right(120)
    end
    turtle.left(240)
    turtle.forward(len2)
  end
end

def sierpinski_triangle(turtle, len, deep)
  len2 = len/2.0

  turtle.regular_polygon(3, len)

  turtle.pen_up
  turtle.forward(len2)
  turtle.right(60)
  turtle.pen_down
  3.times do
    sierpinski(turtle, len2, deep)
    turtle.right(120)
  end
  turtle.pen_up
  turtle.left(60)
  turtle.back(len2)
  turtle.pen_down
end

if __FILE__ == $0
  deep = ARGV[0].to_i
  n = 3
  a = 480
  angle = 360/n

  alfa = 2*Math::PI/n
  r = a/(2*Math.sin(alfa/2))

  size, cx, cy = 2*(r+20), r+20, r+20

  turtle = Turtle::Turtle.new(size, size, { :x => cx, :y => cy-r, :angle => 90+(180-angle)/2 })

  sierpinski_triangle(turtle, a, deep)

  turtle.write('turtle_sierpinski.svg')
end

# $ time ruby sierpinski.rb 0
# 
# real	0m0.048s
# user	0m0.036s
# sys 	0m0.007s
# $ time ruby sierpinski.rb 1
# 
# real	0m0.065s
# user	0m0.041s
# sys 	0m0.016s
# $ time ruby sierpinski.rb 2
# 
# real	0m0.073s
# user	0m0.056s
# sys 	0m0.011s
# $ time ruby sierpinski.rb 3
# 
# real	0m0.133s
# user	0m0.104s
# sys 	0m0.021s
#  $ time ruby sierpinski.rb 4
# 
# real	0m0.299s
# user	0m0.266s
# sys 	0m0.026s
# $ time ruby sierpinski.rb 5
# 
# real	0m0.811s
# user	0m0.756s
# sys 	0m0.042s
# $ time ruby sierpinski.rb 6
# 
# real	0m2.673s
# user	0m2.555s
# sys 	0m0.082s
# $ time ruby sierpinski.rb 7
# 
# real	0m10.108s
# user	0m9.862s
# sys 	0m0.167s
# $ time ruby sierpinski.rb 8
# 
# real	0m52.009s
# user	0m51.043s
# sys 	0m0.512s
