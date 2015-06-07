module LineIntersection
  class Point
    attr_accessor :x, :y

    def initialize(args)
      @x, @y = args[:x].to_f, args[:y].to_f
    end

    def to_s
      "[#{x},#{y}]"
    end
  end
end