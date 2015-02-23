require 'rubygems'
require 'RMagick'

include Magick

class UlamSpiral
  DIRECTIONS = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  # @param [Numeric] size number of columns and rows (size x size)
  def initialize(size)
    @size = size.odd? ? size : size-1
    @current_position = [@size/2, @size/2]
    @direction = 0
  end

  def generate_img(img)
    number = 1
    step = 1

    while number <= @size**2
      2.times do
        step.times do
          x, y = @current_position
          img.pixel_color(x, y, 'black') if block_given? and yield(number)
          number += 1
          xt, yt = DIRECTIONS[@direction]
          @current_position = [x+xt, y+yt]
        end
        @direction = (@direction+1)%4
      end
      step += 1
    end

    img
  end
end