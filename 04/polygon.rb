def intersection(l1, l2)
  # Second version
  # p1, p2, p3, p4 = l1[0], l1[1], l2[0], l2[1]
  # x1, x2, x3, x4 = p1[0] ,p2[0], p3[0], p4[0]
  # y1, y2, y3, y4 = p1[1] ,p2[1], p3[1], p4[1]
  #
  # a1 = y2-y1
  # b1 = x1-x2
  # c1 = (a1*x1)+(b1*y1)
  #
  # a2 = y4-y3
  # b2 = x3-x4
  # c2 = (a2*x3)+(b2*y3)
  #
  # det = a1*b2 - a2*b1
  # det == 0 ? nil : [((b2*c1)-(b1*c2))/det,((a1*c2)-(a2*c1))/det]

  # First version
  # (x1*y2)-(y1*x2)
  a = (l1[0][0]*l1[1][1])-(l1[0][1]*l1[1][0])
  # (x3*y4)-(y3*x4)
  b = (l2[0][0]*l2[1][1])-(l2[0][1]*l2[1][0])
  # (x1-x2)*(y3-y4)
  c = (l1[0][0]-l1[1][0])*(l2[0][1]-l2[1][1])
  # (y1-y2)*(x3-x4)
  d = (l1[0][1]-l1[1][1])*(l2[0][0]-l2[1][0])
  # (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4)
  e = c-d

  x = (a*(l2[0][0]-l2[1][0])-(l1[0][0]-l1[1][0])*b)/e
  y = (a*(l2[0][1]-l2[1][1])-(l1[0][1]-l1[1][1])*b)/e

  [x,y]
end

def vector_length(v)
  Math.sqrt(v[0]**2 + v[1]**2)
end

def normalize_vector(v)
  v_length = vector_length(v)

  [v[0]/v_length, v[1]/v_length]
end

def check_point(l, p)
  # Second version
  x = [l[0][0], l[1][0]]
  y = [l[0][1], l[1][1]]

  min_x, max_x = x.minmax
  min_y, max_y = y.minmax

  p[0] > min_x && p[0] < max_x && p[1] > min_y && p[1] < max_y

  # First version
  # epsilon = 0.0001
  #
  # l_vector = [ l[1][0]-l[0][0], l[1][1]-l[0][1] ]
  # p_vector = [ p[0]-l[0][0]   , p[1]-l[0][1]    ]
  # l_length = vector_length(l_vector)
  # p_length = vector_length(p_vector)
  # l_normalized = normalize_vector(l_vector)
  # p_normalized = normalize_vector(p_vector)
  #
  # puts "#{l_normalized[0]}, #{p_normalized[0]}"
  # Math.acos(l_normalized[0]) - Math.acos(p_normalized[0]) < epsilon && p_length < l_length
end

require 'rubygems'
require 'RMagick'

include Magick

def polygon(size, points)
  minx = miny = size
  maxx = maxy = 0

  lines = (0...points.count).collect do |i|
    minx = points[i][0] if points[i][0] < minx
    miny = points[i][1] if points[i][1] < miny
    maxx = points[i][0] if points[i][0] > maxx
    maxy = points[i][1] if points[i][1] > maxy
    [points[i-1], points[i]]
  end
  img = Image.new(size, size) { self.background_color = 'white' }

  (minx.to_i..maxx.to_i).each do |x|
    (miny.to_i..maxy.to_i).each do |y|
      intersections = []
      lines.each do |l|
        p = intersection(l, [[-1.0, -1.0], [x.to_f, y.to_f]])
        intersections << p if !p.nil? && check_point(l, p)
      end
      img.pixel_color(x, size-y, 'black') if intersections.count.odd?
    end
  end

  img
end

# [[10, 10], [180, 20], [160, 150], [100, 50], [20,180]]
def sample_polygon
  polygon(200, [[10.0, 10.0], [180.0, 20.0], [160.0, 150.0], [100.0, 50.0], [20.0,180.0]])
end

def sample_polygon2
  polygon(512, [[10.0, 10.0], [432.0, 20.0], [390.0, 154.0], [470.0, 490.0], [50.0, 123.0]])
end
