require 'rubygems'
require 'RMagick'

include Magick

module Effects
  def effect1(size, r, a)
    img = Image.new(size, size) { self.background_color = 'white' }
    xc, yc = size/2, size/2

    xor = lambda do |x, y|
      x ^ y
    end

    chessboard = lambda do |x, y, square_edge_length|
      xor.call((x / square_edge_length) % 2 == 0, (y / square_edge_length ) % 2 == 0)
    end

    circles = lambda do |x, y, radius|
      Math.hypot(x - xc, y - yc) % radius > radius / 2 - 1
    end

    (0...size).each do |x|
      (0...size).each do |y|
        img.pixel_color(x, y, 'black') if xor.call(chessboard.call(x, y, a), circles.call(x, y, r))
      end
    end

    img
  end

  # def chessboard(x, y, size, squares)
  #   xor((x / (size / (squares + 1))) % 2 > 1, (y / (size / (squares + 1))) % 2 > 1)
  # end
  #
  # def xor(a, b)
  #   a && !b || !a && b
  # end
  #
  # def circles(x, y, xc, yc, radius)
  #   Math.hypot(x - xc, y - yc) % radius > radius / 2
  # end

  module_function :effect1
end