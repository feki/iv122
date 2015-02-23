require 'rubygems'
require 'RMagick'

include Magick

require 'ulam_spiral'

class Integer
  def prime?
    if self == 0 or self == 1
      return false
    end

    i = 2
    limit = self / i
    while i < limit
      return false if self % i == 0
      i += 1
      limit = self / i
    end

    true
  end
end

if __FILE__ == $0
  size = 640
  img = Image.new(size, size) {
    self.background_color = 'white'
  }

  ulms = UlamSpiral.new(size)
  # img = ulms.generate_img(img) { |number| number.even? }
  img = ulms.generate_img(img) { |number| number.prime? }
  # img = ulms.generate_img(img) { |number| Math.sin(number/180.0*Math::PI).abs < 0.2 }
  # img.display
  img.write 'png:outputs/ulam_prime.png'

  img = Image.new(size, size) {
    self.background_color = 'white'
  }
  ulms = UlamSpiral.new(size)
  img = ulms.generate_img(img) { |number| number % 7 == 0 }
  img.write 'png:outputs/ulam_modulo_7.png'
end
