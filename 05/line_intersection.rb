module LineIntersection
  class Point
    attr_accessor :x, :y

    def initialize(args)
      @x, @y = args[:x].to_f, args[:y].to_f
    end
  end

  class Line
    attr_accessor :p1, :p2

    EPSILON = 0.001

    def initialize(args)
      @p1, @p2 = args[:p1], args[:p2]
    end

    def in_range?(rl, rr, n)
      min, max = rl < rr ? [rl, rr] : [rr, rl]

      min <= n && n <= max
    end

    def check_point(p)
      # y = a*x + b
      # a = (y2-y1)/(x2-x1)
      a = Float(@p2.y - @p1.y) / Float(@p2.x - @p1.x)
      # b = y1-(a*x1)
      b = @p1.y - a * @p1.x

      in_range?(@p1.x, @p2.x, p.x) && in_range?(@p1.y, @p2.y, p.y) && (p.y - (a * p.x + b)).abs < EPSILON
    end

    private :in_range?
  end

  # It returns Point of line-line intersection, nil otherwise
  #
  # http://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
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

    x = (a*(l2.p1.x-l2.p2.x)-(l1.p1.x-l1.p2.x)*b)/e
    y = (a*(l2.p1.y-l2.p2.y)-(l1.p1.y-l1.p2.y)*b)/e

    p = Point.new({:x => x, :y => y})

    return (l1.check_point(p) && l2.check_point(p)) ? p : nil
  end
  
  module_function :ll_intersection
end

if __FILE__ == $0
  
end