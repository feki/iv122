require 'rubygems'
require 'RMagick'

include Magick

require 'gcd'

def visualize_gcd
  size = 256
  img = Image.new(size, size) {
    self.background_color = 'black'
  }

  size.times do |x|
    size.times do |y|
      img.pixel_color(x, size-y, "cmyk(0,0,0,#{yield(x,y)}") if block_given?
    end
  end

  # img.display
  img
end


if __FILE__ == $0
  # gcd size
  img = visualize_gcd { |x,y| Gcd.gcd_modulo(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_size.png'
  # gcd size black
  img = visualize_gcd { |x,y| 255 - (Gcd.gcd_modulo(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_size_black.png'
  # gcd size 4
  img = visualize_gcd { |x,y| 4 * Gcd.gcd_modulo(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_size_4.png'# gcd size
  # gcd size black 4
  img = visualize_gcd { |x,y| 255 - (4 * Gcd.gcd_modulo(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_size_black_4.png'
  # gcd size 16
  img = visualize_gcd { |x,y| 16 * Gcd.gcd_modulo(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_size_16.png'# gcd size
  # gcd size black 16
  img = visualize_gcd { |x,y| 255 - (16 * Gcd.gcd_modulo(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_size_black_16.png'

  # gcd subtract steps
  img = visualize_gcd { |x,y| Gcd.gcd_subtract_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_subtract_steps.png'
  # gcd subtract steps black
  img = visualize_gcd { |x,y| 255 - (Gcd.gcd_subtract_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_subtract_steps_black.png'
  # gcd subtract steps 4
  img = visualize_gcd { |x,y| 4 * Gcd.gcd_subtract_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_subtract_steps_4.png'
  # gcd subtract steps black 4
  img = visualize_gcd { |x,y| 255 - (4 * Gcd.gcd_subtract_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_subtract_steps_black_4.png'
  # gcd subtract steps 16
  img = visualize_gcd { |x,y| 16 * Gcd.gcd_subtract_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_subtract_steps_16.png'
  # gcd subtract steps black 16
  img = visualize_gcd { |x,y| 255 - (16 * Gcd.gcd_subtract_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_subtract_steps_black_16.png'

  # gcd modulo steps
  img = visualize_gcd { |x,y| Gcd.gcd_modulo_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_modulo_steps.png'
  # gcd modulo steps black
  img = visualize_gcd { |x,y| 255 - (Gcd.gcd_modulo_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_modulo_steps_black.png'
  # gcd modulo steps 4
  img = visualize_gcd { |x,y| 4 * Gcd.gcd_modulo_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_modulo_steps_4.png'
  # gcd modulo steps black 4
  img = visualize_gcd { |x,y| 255 - (4 * Gcd.gcd_modulo_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_modulo_steps_black_4.png'
  # gcd modulo steps 8
  img = visualize_gcd { |x,y| 8 * Gcd.gcd_modulo_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_modulo_steps_8.png'
  # gcd modulo steps black 8
  img = visualize_gcd { |x,y| 255 - (8 * Gcd.gcd_modulo_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_modulo_steps_black_8.png'
  # gcd modulo steps 16
  img = visualize_gcd { |x,y| 16 * Gcd.gcd_modulo_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_modulo_steps_16.png'
  # gcd modulo steps black 16
  img = visualize_gcd { |x,y| 255 - (16 * Gcd.gcd_modulo_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_modulo_steps_black_16.png'
  # gcd modulo steps 24
  img = visualize_gcd { |x,y| 24 * Gcd.gcd_modulo_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_modulo_steps_24.png'
  # gcd modulo steps black 24
  img = visualize_gcd { |x,y| 255 - (24 * Gcd.gcd_modulo_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_modulo_steps_black_24.png'
  # gcd modulo steps 32
  img = visualize_gcd { |x,y| 32 * Gcd.gcd_modulo_steps(x+1, y+1) % 256 }
  img.write 'png:outputs/gcd_modulo_steps_32.png'
  # gcd modulo steps black 32
  img = visualize_gcd { |x,y| 255 - (32 * Gcd.gcd_modulo_steps(x+1, y+1) % 256) }
  img.write 'png:outputs/gcd_modulo_steps_black_32.png'
end
