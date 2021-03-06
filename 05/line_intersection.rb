require_relative 'point'
require_relative 'segment'

module LineIntersection
  #
  # It returns Point of line-line intersection, nil otherwise
  #
  # http://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
  #
  # @param l1 [Segment]
  # @param l2 [Segment]
  # @return [Point]
  #
  def ll_intersection(l1, l2, include_end_points=true)
    # (x1*y2)-(y1*x2)
    a = (l1.p1.x*l1.p2.y)-(l1.p1.y*l1.p2.x)
    # (x3*y4)-(y3*x4)
    b = (l2.p1.x*l2.p2.y)-(l2.p1.y*l2.p2.x)
    # (x1-x2)*(y3-y4)
    c = (l1.p1.x-l1.p2.x)*(l2.p1.y-l2.p2.y)
    # (y1-y2)*(x3-x4)
    d = (l1.p1.y-l1.p2.y)*(l2.p1.x-l2.p2.x)
    # (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4)
    e = c-d

    # puts "a: #{a}, b: #{b}, c: #{c}, d: #{d}, e: #{e}"

    if not include_end_points
      if (l1.p1.x == l2.p1.x && l1.p1.y == l2.p1.y) || (l1.p2.x == l2.p1.x && l1.p2.y == l2.p1.y) \
      || (l1.p1.x == l2.p2.x && l1.p1.y == l2.p2.y) || (l1.p2.x == l2.p2.x && l1.p2.y == l2.p2.y)
        return nil
      end
    end

    # the lines/segments ara parallel
    return nil if e == 0

    x = (a*(l2.p1.x-l2.p2.x)-(l1.p1.x-l1.p2.x)*b)/e
    y = (a*(l2.p1.y-l2.p2.y)-(l1.p1.y-l1.p2.y)*b)/e

    # puts "x: #{x}, y: #{y}"

    p = Point.new({:x => x, :y => y})

    (l1.check_point(p) && l2.check_point(p)) ? p : nil
  end
  
  module_function :ll_intersection
end

include LineIntersection

if __FILE__ == $0
  p1 = Point.new x: 10, y: 10
  p2 = Point.new x: 20, y: 20
  p3 = Point.new x: 10, y: 20
  p4 = Point.new x: 20, y: 10
  s1 = Segment.new p1: p1, p2: p2
  s2 = Segment.new p1: p3, p2: p4
  intersection = ll_intersection(s1, s2)
  puts "#{s1} x #{s2} -> #{intersection.nil? ? 'nil' : intersection} (intersection)"

  p1 = Point.new x: 10, y: 10
  p2 = Point.new x: 20, y: 20
  p3 = Point.new x: 11, y: 10
  p4 = Point.new x: 21, y: 20
  s1 = Segment.new p1: p1, p2: p2
  s2 = Segment.new p1: p3, p2: p4
  intersection = ll_intersection(s1, s2)
  puts "#{s1} x #{s2} -> #{intersection.nil? ? 'nil' : intersection} (intersection)"

  p1 = Point.new x: 10, y: 10
  p2 = Point.new x: 20, y: 20
  p3 = Point.new x: 10, y: 10
  p4 = Point.new x: 20, y: 20
  s1 = Segment.new p1: p1, p2: p2
  s2 = Segment.new p1: p3, p2: p4
  intersection = ll_intersection(s1, s2)
  puts "#{s1} x #{s2} -> #{intersection.nil? ? 'nil' : intersection} (intersection)"

  p1 = Point.new x: 10, y: 10
  p2 = Point.new x: 10, y: 20
  p3 = Point.new x: 9, y: 14
  p4 = Point.new x: 11, y: 16
  s1 = Segment.new p1: p1, p2: p2
  s2 = Segment.new p1: p3, p2: p4
  intersection = ll_intersection(s1, s2)
  puts "#{s1} x #{s2} -> #{intersection.nil? ? 'nil' : intersection} (intersection)"
end