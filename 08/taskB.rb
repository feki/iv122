require_relative 'mrcm'
require_relative '../05/segment'
require_relative 'taskA'

require 'benchmark'

include LinearTransformations

if $0 == __FILE__
  length = 500.0

  square = [
      Segment.from_array([[0, 0], [0, length]]),
      Segment.from_array([[0, 0], [length, 0]]),
      Segment.from_array([[length, length], [0, length]]),
      Segment.from_array([[length, length], [length, 0]]),
  ]

  mrcm = Mrcm.new([
                      scaling(0.5, 0.5),
                      combine([scaling(0.5, 0.5), translation(length/2.0, 0.0)]),
                      combine([scaling(0.5, 0.5), translation(length/4.0, length/2.0)])
                  ])

  # segments = mrcm.compute(square, 8)
  # save_to_svg(segments, 'outputs/sierpinski.svg')

  mrcm.transformations = [
      combine([scaling(0.5, 0.5), rotation(180), translation(length/2.0, length/2.0)]),
      combine([scaling(0.5, 0.5), rotation(90), translation(length, 0.0)]),
      combine([scaling(0.5, 0.5), rotation(-90), translation(0.0, length)])
  ]

  # segments = mrcm.compute(square, 6)
  # save_to_svg(segments, 'outputs/sierpinski_relative.svg')

  mrcm.transformations = [
      scaling(0.5, 0.5),
      combine([scaling(0.5, 0.5), translation(-length/2, 0), rotation(60)]),
      combine([scaling(0.5, 0.5), translation(-length/4, length/2), rotation(-60)])
  ]

  # segments = mrcm.compute(square, 8)
  # save_to_svg(segments, 'outputs/sierpinski_relative2.svg')

  mrcm.transformations = [
      [
          [0.255, 0, 0.3726 * length],
          [0, 0.255, 0.6714 * length],
          [0, 0, 1]
      ],
      [
          [0.255, 0, (0.1146 * length)],
          [0.0, 0.255, (0.2232 * length)],
          [0, 0, 1]
      ],
      [
          [0.255, 0, (0.6306 * length)],
          [0, 0.255, (0.2232 * length)],
          [0, 0, 1]
      ],
      [
          [0.370, -0.642, (0.6356 * length)],
          [0.642, 0.370, -0.0061 * length],
          [0, 0, 1]
      ]
  ]

  # segments = mrcm.compute(square, 7)
  # save_to_svg(segments, 'outputs/star.svg')

  mrcm.transformations = [
      [
          [0.255, 0, 0.3726],
          [0, 0.255, 0.6714],
          [0, 0, 1]
      ],
      [
          [0.255, 0, 0.1146],
          [0.0, 0.255, 0.2232],
          [0, 0, 1]
      ],
      [
          [0.255, 0, 0.6306],
          [0, 0.255, 0.2232],
          [0, 0, 1]
      ],
      [
          [0.370, -0.642, 0.6356],
          [0.642, 0.370, -0.0061],
          [0, 0, 1]
      ]
  ]

  Benchmark.bm do |b|
    b.report('Star2') do
      segments = mrcm.compute([Segment.from_array([[0, 0], [0, 0]])], 10)
      save_to_svg(segments, 'outputs/star2.svg')
    end
  end

  mrcm.transformations = [
      [
          [0.849, 0.037, 0.075 * length],
          [-0.037, 0.849, 0.183 * length],
          [0, 0, 1]
      ],
      [
          [0.197, -0.226, 0.4 * length],
          [0.226, 0.197, 0.049 * length],
          [0, 0, 1]
      ],
      [
          [-0.15, 0.283, 0.575 * length],
          [0.26, 0.237, 0.084 * length],
          [0, 0, 1]
      ],
      [
          [0, 0, 0.5 * length],
          [0, 0.16, 0],
          [0, 0, 1]
      ]
  ]

  # Benchmark.bm do |b|
  #   b.report('Barnsley fern') do
  #     segments = mrcm.compute(square, 8)
  #     save_to_svg(segments, 'outputs/barnsley_fern.svg')
  #   end
  # end

end