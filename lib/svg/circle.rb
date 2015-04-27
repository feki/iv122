require File.join(File.dirname(__FILE__), 'shape')

module Svg
  # Svg Circle.
  class Circle < Shape
    # ==== Arguments
    #
    # You may set up svg circle properties:
    #
    # * +:cx+ - x coordinates of the centre of the circle
    # * +:cy+ - y coordinates of the centre of the circle
    # * +:r+ - radius of the circle
    # * for more options look at +Shape+ class
    def initialize(cx, cy, r, args={})
      args2 = args.clone
      args2[:cx] = cx
      args2[:cy] = cy
      args2[:r] = r

      super('circle', args2)
    end

    def min_xy
      radius = @attributes['r']
      [@attributes['cx'] - radius, @attributes['cy'] - radius]
    end

    def max_xy
      radius = @attributes['r']
      [@attributes['cx'] + radius, @attributes['cy'] + radius]
    end

    def translate_xy(x, y)
      @attributes['cx'] += x
      @attributes['cy'] += y
    end
  end
end