require '../lib/turtle_graphics/turtle'

def turtle_regular_polygon(turtle, n, len, &code)
  angle = 360.0 / n
  n.times do
    code.call(turtle) if code

    turtle.forward(len)
    turtle.left(angle)
  end
end

# ruby turtle_regular_polygon.rb 12 30
if __FILE__ == $0
  n = ARGV[0].to_i
  len_a = ARGV[1].to_i

  # internal angle
  angle = 360.0/n
  alfa = 2*Math::PI/n
  r = len_a/(2*Math.sin(alfa/2))
  p = len_a/(2*Math.tan(alfa/2))

  size, cx, cy = 2*(r+20), r+20, r+20

  turtle = Turtle::Turtle.new(size, size, {angle: 0})
    # if n.odd?
    #   Turtle::Turtle.new(size, size, { :x => cx, :y => cy-r, :angle => 90+(180-angle)/2 })
    # else
    #   Turtle::Turtle.new(size, size, { :x => cx-p, :y => cy+len_a/2, :angle => (180-angle)-90 })
    # end


  turtle_regular_polygon(turtle, n, len_a) do |t|
    # turtle.svg.add_shape(Svg::Line.new :x1 => cx, :y1 => cy, :x2 => t.position[0], :y2 => t.position[1])
  end

  turtle.write("outputs/turtle_regular_polygon_n#{n}.svg")
end
