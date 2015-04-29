require File.dirname(__FILE__) + '/../svg/svg'
require File.dirname(__FILE__) + '/../svg/line'

module Turtle
  class Turtle

    attr_accessor :position, :angle, :pen, :svg, :do_step

    def initialize(height, width, args={})
      @svg = Svg::Svg.new :width => width, :height => height

      x = args[:x] || 0
      y = args[:y] || 0
      angle = args[:angle] || 90.0
      @position, @angle, @pen = [x, y], angle, true
    end

    def forward(step)
      do_step(@angle, step)
    end

    def back(step)
      angle = opposite_angle(@angle)
      do_step(angle, step)
    end

    def right(angle)
      change_angle(-angle)
    end

    def left(angle)
      change_angle(angle)
    end

    def pen_up
      @pen = false
    end

    def pen_down
      @pen = true
    end

    def write(file_name)
      @svg.doc.write(File.new(file_name, 'w'))
    end

    def do_step(angle, step)
      x, y = @position
      nx, ny = new_position(angle, step)

      @svg.add_shape(Svg::Line.new(x, y, nx, ny)) if @pen
    end

    # It returns new position after step.
    def new_position(angle, step)
      radians = Math::PI*(angle/180.0)
      @position[0] = @position[0] + step*Math.cos(radians)
      @position[1] = @position[1] + step*Math.sin(radians)

      @position
    end

    def change_angle(angle)
      @angle = (@angle + angle) % 360
    end

    def opposite_angle(angle)
      (angle + 180) % 360
    end

    # @param [Integer] n number of edges
    # @param [Numeric] a length of side
    def regular_polygon(n, a)
      angle = 360.0 / n
      n.times do
        forward(a)
        right(angle)
      end
    end

    private :change_angle, :opposite_angle, :do_step, :new_position

  end
end
