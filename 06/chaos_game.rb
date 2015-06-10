require 'rubygems'
require 'RMagick'

include Magick

module ChaosGame
  # ==== Parameters
  #
  # * +a+ - edge length of regular polygon
  # * +n+ - number of vertices and edges
  def chaos_game(a, n, ratio=0.5, i_count=1000000, i_left=10000)
    alfa = 2*Math::PI/n
    r = a/(2*Math.sin(alfa/2))
    size, cx, cy = 2*(r+20), r+20, r+20
    img = Image.new(size, size) { self.background_color = 'white' }
    # Coordinates of polygon points
    points = (0...n).collect { |i| [cx+r*Math.cos(i*alfa+Math::PI/2), cy+r*Math.sin(i*alfa+Math::PI/2)] }

    x, y = 0, 0
    i_count.times do |i|
      rand_point = points[rand(n)]
      x, y = rand_point[0]+(x-rand_point[0])*ratio, rand_point[1]+(y-rand_point[1])*ratio
      img.pixel_color(x, size-y, 'black') if i >= i_left
    end

    return img
  end
  
  module_function :chaos_game
end

if __FILE__ == $0
  img = ChaosGame.chaos_game(500, 3)
  # img.display
  img.write 'png:outputs/chaos_game.png'

  img = ChaosGame.chaos_game(500, 6, 0.375)
  # img.display
  img.write 'png:outputs/chaos_game2.png'

  img = ChaosGame.chaos_game(15, 312, 0.005)
  # img.display
  img.write 'png:outputs/chaos_game3.png'
end
