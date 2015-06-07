require_relative 'line_intersection'
require_relative 'g_utils'

require_relative '../lib/svg/svg'
require_relative '../lib/svg/line'
require_relative '../lib/svg/point'

include GUtils
include LineIntersection

#
# It generates N segments each of length L and finds their intersections.
# It saves to outputs/intersections.svg file.
#
# USAGE: ruby taskA.rb N L output_size
# EXAMLPLE: ruby taskA.rb 50 20
#
if $0 == __FILE__

  number_of_segments = ARGV[0].empty? ? 50 : ARGV[0].to_i
  segment_length = ARGV[1].empty? ? 20 : ARGV[1].to_i
  size = ARGV[2].empty? ? 255 : ARGV[2].to_i

  segments = GUtils.get_random_segments(number_of_segments, segment_length, size)

  svg = Svg::Svg.new :width => size, :height => size
  segments.each do |s|
    svg.add_shape(Svg::Line.new(s.p1.x, s.p1.y, s.p2.x, s.p2.y))
  end

  intersections = []
  while not segments.empty?
    s = segments.pop
    segments.each do |s2|
      intersection = ll_intersection(s,s2)
      intersections.push intersection
    end
  end

  intersections.compact.each do |i|
    svg.add_shape(Svg::Point.new(i.x, i.y, fill: 'red'))
  end

  svg.doc.write File.new('outputs/intersections.svg', 'w')
end
