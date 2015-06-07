require_relative 'segment'
require_relative 'point'

module Triangulation
  #
  # It generates and returns all segments between each pair of points.
  #
  # @param [Array<LineIntersection::Point>] points
  #
  def get_all_segments(points)
    points.combination(2).map do |com|
      LineIntersection::Segment.new p1: com[0], p2: com[1]
    end
  end

  module_function :get_all_segments
end