require 'pascal_triangle'
require '../lib/svg/svg'
require '../lib/svg/rectangle'

$colors = ['Green', 'White', 'Red', 'Maroon', 'Yellow', 'Olive', 'Lime', 'Gray', 'Aqua', 'Black', 'Silver', 'Teal', 'Blue', 'Navy', 'Fuchsia', 'Purple']


# Vstup: n, d
# Výstup: Prvních n rádkù Pascalova trojúhelníku, pricemz vsak nevypisujeme prímo císla,
# ale znázornujeme zbytek po delení d.
def create_pascal_triangle(n, d, filename='pascal_triangle.svg')
  svg_file1 = Svg::Svg.new :width => n*10, :height => n*10
  triangle = PascalTriangle.new(n).pascal_triangle

  for level in n.downto(1)
    triangle[level-1].each_index do |number_index|
      x, y, color = (n-level)*5 + number_index*10, (level-1)*10, $colors[triangle[level-1][number_index]%d]

      svg_file1.add_shape(Svg::Rectangle.new(x, y, 10, 10, { :fill => color }))
    end
  end

  svg_file1.doc.write File.new('outputs/pascal_triangle.svg', "w")
end

if __FILE__ == $0
  n, d = 50, 8
  triangle = create_pascal_triangle(n, d)
end
