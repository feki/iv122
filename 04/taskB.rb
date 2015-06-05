require './shapes'

if __FILE__ == $0
  # sample_polygon
  img = Shapes.sample_polygon
  img.write 'png:outputs/sample_polygon.png'

  # sample_polygon2
  img = Shapes.sample_polygon2
  img.write 'png:outputs/sample_polygon2.png'
end
