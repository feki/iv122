require_relative 'pascal_triangle'
require '../lib/svg/svg'
require '../lib/svg/rectangle'

#
# Použité farby. Ich index v poli predstavuje zbytok po delení.
#
$colors = %w(Green Blue Red Maroon Yellow Olive Lime Gray Aqua Black Silver Teal White Navy Fuchsia Purple)

#
# Vstup: n (počet riadkov Pascalovho trojuholníka), d (číslo, ktorým sa bude deliť a získavať tak zbytok po delení)
# Výstup: Prvých n riadkov Pascalovho trojúhelníka, pričom však nevypisujeme priamo čísla,
# ale znázorňujeme zbytok po delení číslom d. Výstup je uložený do outputs/filename.svg súbora.
#
def create_pascal_triangle(n, d, filename='pascal_triangle')
  svg = Svg::Svg.new width: n*10, height: n*10
  triangle = PascalTriangle.new(n).pascal_triangle

  for level in n.downto(1)
    triangle[level-1].each_index do |number_index|
      x = (n-level)*5 + number_index*10
      y = (level-1)*10
      color = $colors[triangle[level-1][number_index]%d]

      svg.add_shape(Svg::Rectangle.new(x, y, 10, 10, {fill: color}))
    end
  end

  svg.doc.write File.new("outputs/#{filename}.svg", 'w')
end

if __FILE__ == $0
  # create_pascal_triangle(50, 8, 'pascal_triangle_50x8')
  # create_pascal_triangle(30, 5, 'pascal_triangle_30x5')
  # create_pascal_triangle(150, 17, 'pascal_triangle_150x17')
  # create_pascal_triangle(150, 16, 'pascal_triangle_150x16')

  for i in 1..$colors.length do
    create_pascal_triangle(150, i, "pascal_triangle_150x#{i}")
  end
end
