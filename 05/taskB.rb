require_relative 'line_intersection'
require_relative 'g_utils'

require_relative 'triangulation'

require_relative '../lib/svg/svg'
require_relative '../lib/svg/line'
require_relative '../lib/svg/point'
require_relative '../lib/svg/circle'

include GUtils
include LineIntersection
include Triangulation

def has_intersection(s, arr)
  for ss in arr do
    intersect = ll_intersection(s, ss, false)
    if not intersect.nil?
      return true
    end
  end

  return false
end

#
# It generates N random points and finds their triangulation.
# It saves to outputs/triangulation.svg file.
#
# USAGE: ruby taskB.rb N output_size
# EXAMLPLE: ruby taskB.rb 50 512
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

  all_segments = get_all_segments(points).sort_by { |s| s.length }

  # all_segments.each do |s|
  #   # svg.add_shape(Svg::Line.new(s.p1.x, s.p1.y, s.p2.x, s.p2.y))
  #   puts "#{s} length: #{s.length}"
  # end

  selected_segments = []
  all_segments.each do |s|
    if not has_intersection(s, selected_segments)
      selected_segments.push s
    end
  end

    selected_segments.each do |s|
      svg.add_shape(Svg::Line.new(s.p1.x, s.p1.y, s.p2.x, s.p2.y))
    end

    svg.doc.write File.new('outputs/triangulation.svg', 'w')

end