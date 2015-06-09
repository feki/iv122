require_relative '../lib/matrices/linear_transformations'
require_relative '../05/segment'

require_relative '../lib/svg/svg'
require_relative '../lib/svg/line'

include LinearTransformations
include LineIntersection

#
# It saves segments to svg file.
#
def save_to_svg(segments, filename)
  size = 512
  svg = Svg::Svg.new :width => size, :height => size

  segments.each do |s|
    svg.add_shape(Svg::Line.new(s.p1.x, s.p1.y, s.p2.x, s.p2.y))
  end

  svg.doc.write File.new(filename, 'w')
end

if $0 == __FILE__
  # repeat: 10, rotation: 20, scaling: (1.1,1.1), translation: (5,10)
  segments = [
      Segment.from_array([[0,0],[0,1]]),
      Segment.from_array([[0,0],[1,0]]),
      Segment.from_array([[1,1],[0,1]]),
      Segment.from_array([[1,1],[1,0]]),
  ]

  segments = translate_segments(segments, scaling(50.0,50.0))

  translations = [rotation(20.0), scaling(1.1,1.1), translation(5.0,10.0)]
  all_transformed_segments = translate(segments,translations,10)
  # all_transformed_segments = translate_segments(all_transformed_segments,scaling(100.0,100.0))
  save_to_svg(all_transformed_segments, 'outputs/translations1.svg')

  translations = [rotation(20.0), scaling(1.1,1.1), translation(5.0,10.0), reflection]
  all_transformed_segments = translate(segments,translations,20)
  save_to_svg(all_transformed_segments, 'outputs/translations2.svg')

  segments = translate_segments([
                                    Segment.from_array([[-1,-1],[-1,1]]),
                                    Segment.from_array([[-1,-1],[1,-1]]),
                                    Segment.from_array([[1,1],[-1,1]]),
                                    Segment.from_array([[1,1],[1,-1]]),
                                ], scaling(50.0,50.0))

  # shear(1.3), rotation(10), scaling(0.9,0.9),translation(50, 50)
  translations = [translation(50.0,50.0), scaling(0.9,0.9), rotation(10.0), shear(1.3)]
  all_transformed_segments = translate(segments,translations,25)
  save_to_svg(all_transformed_segments, 'outputs/translations3.svg')

  translations = [rotation(-10.0), scaling(1.1,0.8)]
  all_transformed_segments = translate(segments,translations,18)
  all_transformed_segments = translate_segments(all_transformed_segments,scaling(10.0,10.0))
  save_to_svg(all_transformed_segments, 'outputs/translations4.svg')
end