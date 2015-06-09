require_relative 'basic_operations'
require_relative '../../05/point'
require_relative '../../05/segment'

module LinearTransformations
  #
  # Translation.
  #
  def translation(tx, ty)
    [
      [ 1.0, 0.0,  tx ],
      [ 0.0, 1.0,  ty ],
      [ 0.0, 0.0, 1.0 ]
    ]
  end

  #
  # Reflexion.
  #
  def reflection
    [
      [ -1.0, 0.0, 0.0 ],
      [  0.0, 1.0, 0.0 ],
      [  0.0, 0.0, 1.0 ]
    ]
  end

  #
  # Scaling.
  #
  def scaling(sx, sy)
    [
      [  sx, 0.0, 0.0 ],
      [ 0.0,  sy, 0.0 ],
      [ 0.0, 0.0, 1.0 ]
    ]
  end

  #
  # Rotation.
  #
  def rotation(angle)
    alfa = 2*Math::PI*(angle/360.0)
    cosa = Math.cos(alfa)
    sina = Math.sin(alfa)

    [
      [ cosa, -sina, 0.0 ],
      [ sina,  cosa, 0.0 ],
      [  0.0,   0.0, 1.0 ]
    ]
  end

  #
  # Shear.
  #
  def shear(k)
    [
      [ 1.0,   k, 0.0 ],
      [ 0.0, 1.0, 0.0 ],
      [ 0.0, 0.0, 1.0 ]
    ]
  end

  #
  # It combines list of linear combinations.
  #
  # @param [Array] transformations
  # @return [Array]
  #
  def combine(transformations)
    res = transformations[0]
    if transformations.count > 1
      res = transformations[1..-1].inject(res) { |mem, tran| BasicOperations.multiplication(mem, tran) }
    end
    res
  end

  #
  # It transforms given point with transformation matrix.
  #
  def translate_point(point, transformation)
    p = [[point.x], [point.y], [1]]
    r = BasicOperations.multiplication(transformation, p)

    LineIntersection::Point.new x: r[0][0], y: r[1][0]
  end

  #
  # It transforms given segment with transformation matrix.
  #
  def translate_segment(segment, transformation)
    p1 = translate_point(segment.p1, transformation)
    p2 = translate_point(segment.p2, transformation)

    LineIntersection::Segment.new p1: p1, p2: p2
  end

  #
  #
  #
  def translate_segments(segments, transformation)
    segments.map { |s| translate_segment(s, transformation) }
  end

  #
  # It transforms given segments over all transformation matrices and repeats it repeat-times.
  # Then it returns list of new lines.
  #
  def translate(segments, transformations, repeat)
    transformation = combine(transformations)

    res = segments
    prev = segments
    repeat.times do
      prev = translate_segments(prev, transformation)
      res += prev
    end

    res
  end

  module_function :translation, :reflection, :scaling, :rotation, :shear, :combine
end

# Linear transformation tests
if $0 == __FILE__
  include LinearTransformations

  point = LineIntersection::Point.new x: 0, y: 0
  puts "#{point} translation(5,10) = #{translate_point(point, translation(5,10))}"

  point = LineIntersection::Point.new x: 1, y: 1
  puts "#{point} shear(1.3) = #{translate_point(point, shear(1.3))}"
end
