require_relative 'point'
require_relative 'segment'

module GUtils
  def get_random_points(number_of_points, max_x, max_y)
    (0...number_of_points).to_a.map do |i|
      srand(i)
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

  def get_random_segments(number_of_segments, length)
    get_random_points(number_of_segments, 255, 255).map do |p|
      angle = get_random_angle
      x2 = length * Math.cos(angle) + p.x
      y2 = length * Math.sin(angle) + p.y
      LineIntersection::Segment.new(p1: p, p2: LineIntersection::Point.new(x: x2, y: y2))
    end
  end

  def get_random_angle
    rand * (2 * Math::PI)
  end

  module_function :get_random_segments, :get_random_angle, :get_random_points
end

require_relative '../lib/svg/svg'
require_relative '../lib/svg/line'

if $0 == __FILE__
  segments = GUtils.get_random_segments(ARGV[0].to_i, ARGV[1].to_i)
  svg = Svg::Svg.new :width => 255, :height => 255
  segments.each do |s|
    svg.add_shape(Svg::Line.new(s.p1.x, s.p1.y, s.p2.x, s.p2.y))
  end
  svg.doc.write File.new('outputs/segments.svg', 'w')
end