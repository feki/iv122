require_relative 'point'
require_relative 'segment'

module LineIntersection
  # It returns Point of line-line intersection, nil otherwise
  #
  # http://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
  #
  # @param l1 [Segment]
  # @param l2 [Segment]
  # @return [Point]
  def ll_intersection(l1, l2)
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

    return nil if e == 0

    x = (a*(l2.p1.x-l2.p2.x)-(l1.p1.x-l1.p2.x)*b)/e
    y = (a*(l2.p1.y-l2.p2.y)-(l1.p1.y-l1.p2.y)*b)/e

    p = Point.new({:x => x, :y => y})

    (l1.check_point(p) && l2.check_point(p)) ? p : nil
  end
  
  module_function :ll_intersection
end

if __FILE__ == $0
  
end