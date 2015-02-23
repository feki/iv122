require File.join(File.dirname(__FILE__), 'circle')

module Svg
  class Point < Circle
    # ==== Arguments
    #
    # You may set up svg point properties:
    #
    # * +:x+ - x coordinates of the centre of the point
    # * +:y+ - y coordinates of the centre of the point
    def initialize(x, y, args={})
      super(x, y, 1, args)
    end
  end
end
