module Polygon
  class Point < Struct.new(:x, :y)
    def self.new_by_array(arr)
      self.new(arr[0], arr[1])
    end

    def ==(another_point)
      x === another_point.x && y === another_point.y
    end
  end

  class Vector < Struct.new(:x, :y)
    # @param vector [Vector]
    def ==(vector)
      x === vector.x && y === vector.y
    end

    # Length of the vector.
    def length
      Math.hypot(x, y)
    end

    # @param vector [Vector]
    def +(vector)
      Vector.new(x + vector.x, y + vector.y)
    end

    # @param vector [Vector]
    def -(vector)
      self + (-1) * vector
    end

    # @param scalar [Numeric]
    def *(scalar)
      Vector.new(x * scalar, y * scalar)
    end
  end

  class Segment < Struct.new(:point1, :point2)
    def self.new_by_arrays(arr1, arr2)
      self.new(Point.new_by_array(arr1), Point.new_by_array(arr2))
    end

    # @param line [Segment]
    # @return [TrueClass, FalseClass]
    def intersects_with?(line)

    end

    # It computes intersection point with other segment.
    #
    # @param segment [Segment] other segment
    # @return [Point] intersection point
    # @raise [Exception] when segments are parallel
    def intersection_point(segment)
      # numerator = (line.point1.y - point1.y) * (line.point1.x - line.point2.x) -
      #     (line.point1.y - line.point2.y) * (line.point1.x - point1.x)
      # denominator = (point2.y - point1.y) * (line.point1.x - line.point2.x) -
      #     (line.point1.y - line.point2.y) * (point2.x - point1.x)
      #
      # t = numerator.to_f / denominator
      #
      # x = point1.x + t * (point2.x - point1.x)
      # y = point1.y + t * (point2.y - point1.y)
      #
      # Point.new(x, y)

      x1, y1, x2, y2 = point1.x, point1.y, point2.x, point2.y
      x3, y3, x4, y4 = segment.point1.x, segment.point1.y, segment.point2.x, segment.point2.y

      x12 = x1 - x2
      x34 = x3 - x4
      y12 = y1 - y2
      y34 = y3 - y4

      c = x12 * y34 - y12 * x34

      raise Exception.new('Segments are parallel.') if c.zero?

      a = x1 * y2 - y1 * x2
      b = x3 * y4 - y3 * x4

      x = (a * x34 - b * x12) / c
      y = (a * y34 - b * y12) / c

      Point.new(x, y)
    end
  end

  class Border < Struct.new(:bottom_left_point, :top_right_point)
    # @param point [Point]
    def contains?(point)
      point.x.between?(bottom_left_point.x, top_right_point.x) && point.y.between?(bottom_left_point.y, top_right_point.y)
    end
  end
  
  class Polygon < Struct.new(:vertices)
    def edges
      @_edges = (0...vertices.count).collect { |i| Segment.new_by_arrays(vertices[i-1], vertices[i]) } unless @_edges
      @_edges
    end
  end
end
