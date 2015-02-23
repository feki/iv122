require 'shapes'

if __FILE__ == $0
  # circle_full
  img = Shapes.circle_full(512, 220)
  img.write 'png:outputs/circle_full.png'

  # circle_impl
  img = Shapes.circle_impl(512, 220, 0.005)
  img.write 'png:outputs/circle_impl.png'

  # circle_par
  img = Shapes.circle_par(512, 220)
  img.write 'png:outputs/circle_par.png'

  # spiral
  img = Shapes.spiral(512, 10)
  img.write 'png:outputs/spiral.png'

  # triangle
  img = Shapes.triangle(512)
  img.write 'png:outputs/triangle.png'

  # ellipse
  img = Shapes.ellipse(512, 220, 92, 33)
  img.write 'png:outputs/ellipse.png'
end
