require File.join(File.dirname(__FILE__), 'shape')

module Svg
  # Svg Line.
  class Line < Shape 
    # ==== Arguments
    #
    # You may set up svg line properties:
    #
    # * +:x1+ - x coordinates of starting point
    # * +:y1+ - y coordinates of starting point
    # * +:x2+ - x coordinates of end point
    # * +:y2+ - y coordinates of end point
    # * for more options look at +Shape+ class
    def initialize(x1, y1, x2, y2, args={})
      args2 = args.clone
      args2[:x1] = x1
      args2[:y1] = y1
      args2[:x2] = x2
      args2[:y2] = y2

      super('line', args2)
    end

    def min_xy
      [[@attributes['x1'], @attributes['x2']].min, [@attributes['y1'], @attributes['y2']].min]
    end

    def max_xy
      [[@attributes['x1'], @attributes['x2']].max, [@attributes['y1'], @attributes['y2']].max]
    end

    def translate_xy(x, y)
      @attributes['x1'] += x
      @attributes['x2'] += x
      @attributes['y1'] += y
      @attributes['y2'] += y
    end
  end
end
