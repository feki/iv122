require '../lib/turtle_graphics/turtle'
require '../lib/svg/point'

def turtle_star_polygon(turtle, n, k, len_a, &code)
  alfa = 2*Math::PI/n
  angle = k*360.0/n
  r = len_a/(2*Math.sin(alfa/2))
  len = 2*(Math.sin(alfa*(k/2.0))*r)

  # if n%k == 0
  #   k.times do
  #     (n/k).times do 
  #       code.call(turtle) if code

  #       turtle.forward(len)
  #       turtle.right(angle)
  #     end

  #     turtle.penup
  #     turtle.forward(2*(Math.sin(alfa*((k-1)/2.0))*r))
  #     turtle.right()
  #     turtle.pendown
  #   end
  # else
    n.times do
      code.call(turtle) if code

      turtle.forward(len)
      turtle.right(angle)
    end
  # end
end

# ruby turtle_star_polygon.rb 12 5 30
if __FILE__ == $0
  n = ARGV[0].to_i
  k = ARGV[1].to_i
  len_a = ARGV[2].to_i

  # internal angle
  alfa = 2*Math::PI/n
  angle = k*360.0/n%180
  r = len_a/(2*Math.sin(alfa/2))
  p = len_a/(2*Math.tan(alfa/2))

  size, cx, cy = 2*(r+20), r+20, r+20

  turtle =
    if n.odd?
      # puts 90+(180-angle)/2
      Turtle::Turtle.new(size, size, { :x => cx, :y => cy-r, :angle => 90+(180-angle)/2 })
    else
      # puts angle-90
      # TODO: dokoncit transformaciu pociatocneho bodu, jeho posunutie
      Turtle::Turtle.new(size, size, { :x => cx-p, :y => cy-  len_a/2, :angle => 90-k*360.0/n })
    end

  turtle.svg.add_shape(Svg::Point.new(turtle.position[0], turtle.position[1]))
  turtle_star_polygon(turtle, n, k, len_a)

  turtle.write("outputs/turtle_star_polygon_n#{n}_k#{k}.svg")
end

