module LineIntersection
  class Segment
    attr_accessor :p1, :p2

    EPSILON = 0.001

    # @param arr [Array]
    # @return [Segment]
    def self.from_array(arr)
      Segment.new p1: Point.new(x: arr[0][0], y: arr[0][1]), p2: Point.new(x: arr[1][0], y: arr[1][1])
    end

    #
    # Segment.new p1: start_point, p2: end_point
    #
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

      # puts "a: #{a}, b: #{b}"

      on_segment = if @p1.x == @p2.x then
                     true
                   else
                     (p.y - (a * p.x + b)).abs < EPSILON
                   end

      in_range?(@p1.x, @p2.x, p.x) && in_range?(@p1.y, @p2.y, p.y) && on_segment
    end

    #
    # It returns length of segment.
    #
    def length
      @length = @length || Math.hypot(@p2.x-@p1.x, @p2.y-@p1.y)
    end

    def to_s
      "[#{@p1},#{@p2}]"
    end

    private :in_range?
  end
end