require_relative 'convex_hull'
require_relative 'g_utils'

require_relative '../lib/svg/svg'
require_relative '../lib/svg/line'
require_relative '../lib/svg/point'
require_relative '../lib/svg/circle'

include GUtils
include LineIntersection

#
# It generates N random points and finds their convex hull.
# It saves to outputs/convex_hull.svg file.
#
# USAGE: ruby taskC.rb N output_size
# EXAMLPLE: ruby taskC.rb 50 512
#
if $0 == __FILE__

  number_of_points = ARGV[0].to_i
  size = ARGV[1].empty? ? 512 : ARGV[1].to_i

  points = get_random_points(number_of_points, size, size)

  svg = Svg::Svg.new :width => size, :height => size
  points.each do |p|
    svg.add_shape(Svg::Circle.new(p.x, p.y, 3, fill: 'green'))
    # svg.add_shape(Svg::Point.new(p.x, p.y))
  end

  while points.size > 3
    convex_hull_set = ConvexHull.gift_wrapping(points)

    (0...convex_hull_set.size).each { |i|
      p1 = convex_hull_set[i-1]
      p2 = convex_hull_set[i]
      svg.add_shape(Svg::Line.new(p1.x, p1.y, p2.x, p2.y))

      points.delete p2
    }
  end

  svg.doc.write File.new('outputs/convex_hull.svg', 'w')

end