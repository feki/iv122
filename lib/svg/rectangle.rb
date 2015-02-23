require File.join(File.dirname(__FILE__), 'shape')

module Svg
  class Rectangle < Shape
    # ==== Arguments
    #
    # You may set up svg rectangle properties:
    #
    # * +:x+ - x coordinates of the rectangle
    # * +:y+ - y coordinates of the rectangle
    # * +:width+ - width of the rectangle
    # * +:height+ - height of the rectangle
    # * for more options look at +Shape+ class
    def initialize(x, y, width, height, args={})
      args2 = args.clone
      args2[:x] = x
      args2[:y] = y
      args2[:width] = width
      args2[:height] = height

      super('rect', args2)
    end
  end
end
