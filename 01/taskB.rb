require 'rubygems'
require 'RMagick'

require '../lib/svg/svg'
require '../lib/svg/line'

include Magick

def bitmap_method
  img = Image.new(256, 256) {
    self.background_color = 'white'
  }

  256.times do |x|
    256.times do |y|
      img.pixel_color(x, 255 - y, "rgb(#{x},0,#{255-y})")
      # img.pixel_color(x, 255 - y, "rgb(#{x},#{(x-y).abs},#{255-y})")
    end
  end

  # img.display
  img.write('png:outputs/output.png')
end

def svg_method(size)
  size_2 = size/2.0
  size_20 = size/20.0

  svg_line_args = {:swidth => 2}

  svg = Svg::Svg.new :width => size, :height => size
  (0..10).each do |i|
    svg.add_shape(Svg::Line.new(i*size_20, size_2, size_2, size_2-i*size_20, svg_line_args))
    svg.add_shape(Svg::Line.new(size-i*size_20, size_2, size_2, size_2-i*size_20, svg_line_args))
    svg.add_shape(Svg::Line.new(i*size_20, size_2, size_2, size_2+i*size_20, svg_line_args))
    svg.add_shape(Svg::Line.new(size-i*size_20, size_2, size_2, size_2+i*size_20, svg_line_args))
  end
  svg.doc.write File.new('outputs/svg_graphics.svg', 'w')
end

if __FILE__ == $0
  bitmap_method
  svg_method(640)
end