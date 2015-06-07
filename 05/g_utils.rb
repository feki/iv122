require_relative 'point'
require_relative 'segment'

module GUtils
  #
  # It returns collection of random points.
  #
  def get_random_points(number_of_points, max_x, max_y)
    (0...number_of_points).to_a.map do |i|
      srand
      x = rand(0..max_x)
      y = rand(0..max_y)
      LineIntersection::Point.new x: x, y: y
    end

    # result = []
    # i = 0
    # while i < number_of_points
    #   srand(i)
    #   x = rand(0..max_x)
    #   y = rand(0..max_y)
    #   result << LineIntersection::Point.new(x: x, y: y)
    #
    #   i += 1
    # end
    # result
  end

  #
  # It returns N random segments each of length L.
  #
  def get_random_segments(number_of_segments, length, size)
    get_random_points(number_of_segments, size, size).map do |p|
      angle = get_random_angle
      x2 = length * Math.cos(angle) + p.x
      y2 = length * Math.sin(angle) + p.y
      LineIntersection::Segment.new(p1: p, p2: LineIntersection::Point.new(x: x2, y: y2))
    end
  end

  #
  # It returns random angle.
  #
  def get_random_angle
    rand * (2 * Math::PI)
  end

  module_function :get_random_segments, :get_random_angle, :get_random_points
end

require_relative '../lib/svg/svg'
require_relative '../lib/svg/line'

#
# It generates N segments each of length L. It saves to outputs/segments.svg file.
#
# USAGE: ruby g_utils.rb N L
# EXAMLPLE: ruby g_utils.rb 50 20
#
if $0 == __FILE__

  number_of_segments = ARGV[0].to_i || 50
  segment_length = ARGV[1].to_i || 20

  segments = GUtils.get_random_segments(number_of_segments, segment_length)
  svg = Svg::Svg.new :width => 255, :height => 255
  segments.each do |s|
    svg.add_shape(Svg::Line.new(s.p1.x, s.p1.y, s.p2.x, s.p2.y))
  end
  svg.doc.write File.new('outputs/segments.svg', 'w')
end