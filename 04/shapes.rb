require 'rubygems'
require 'RMagick'
require_relative './../05/line_intersection'

include Magick

#
#
#
module Shapes
  #
  #
  #
  def circle_full(size, r)
    img = Image.new(size, size) { self.background_color = 'white' }
    cx = cy = size/2.0
    (0...size).each do |x|
      (0...size).each do |y|
        img.pixel_color(x, y, 'black') if Math.hypot(x-cx, y-cy) <= r
      end
    end

    img
  end

  #
  #
  #
  def circle_impl(size, r, epsilon = 0.05)
    img = Image.new(size, size) { self.background_color = 'white' }
    cx = cy = size/2.0
    (0...size).each do |x|
      (0...size).each do |y|
        img.pixel_color(x, y, 'black') if (((x-cx)**2 + (y-cy)**2 - r**2) / r**2).abs < epsilon
      end
    end

    img
  end

  #
  #
  #
  def circle_par(size, r)
    img = Image.new(size, size) { self.background_color = 'white' }
    cx = cy = size/2.0
    
    t = 0.0
    while t < 2*Math::PI
      img.pixel_color((cx + r * Math.cos(t)).to_int, (cy + r * Math.sin(t)).to_int, 'black')
      t += 0.001
    end

    img
  end

  #
  #
  #
  def spiral(size, s)
    img = Image.new(size, size) { self.background_color = 'white' }
    cx = cy = size/2.0
    const_2pi = 2*Math::PI

    t = 0.0
    while t < const_2pi
      r = s * (t / const_2pi)
      while r < size/2.0
        x = (cx + r * Math.cos(t)).to_int
        y = (cy + r * Math.sin(t)).to_int

        img.pixel_color(x, y, "rgb(#{x/size.to_f*255}, 0, #{y/size.to_f*255})")

        r += s
      end
      t += 0.001
    end

    img
  end

  #
  # Rovnostranny trojuholnik so stranou a
  #
  def triangle(a)
    sqrt3 = Math.sqrt(3)
    m = a*sqrt3/2
    
    img = Image.new(a, m.to_i) { self.background_color = 'white' }

    av, bv, cv = [0, m], [a, m], [a/2.0, 0]
    color_triangle = lambda { |curr, ver| 255 - Math.sqrt((ver[0]-curr[0])**2 + (ver[1]-curr[1])**2)/a * 255 }

    ((-a/2)..(a/2)).each do |x|
      n = sqrt3*x
      (0...m.to_i).each do |y|
        ca = color_triangle.call([x+a/2, m-y-1], av)
        cb = color_triangle.call([x+a/2, m-y-1], bv)
        cc = color_triangle.call([x+a/2, m-y-1], cv)
        img.pixel_color(x+a/2, m-y-1, "cmyk(#{ca},#{cb},#{cc},0)") if y <= m-n and y <= m+n
      end
    end

    img
  end

  #
  #
  #
  def ellipse(size, a, b, angle = 0)
    img = Image.new(size, size) { self.background_color = 'white' }
    
    ex = ey = size/2.0
    radians = 2*Math::PI*((angle%360)/360.0)

    # http://math.stackexchange.com/questions/426150/what-is-the-general-equation-of-the-ellipse-that-is-not-in-the-origin-and-rotate
    (0...size).each do |x|
      (0...size).each do |y|
        # Bez rotacie
        # r = (x-ex)**2/a**2 + (y-ey)**2/b**2
        # img.pixel_color(x, y, "cmyk(0,0,0,#{255*(1-r)})") if r <= 1

        # S rotaciou
        nx = (x-ex)*Math.cos(radians) - (y-ey)*Math.sin(radians)
        ny = (x-ex)*Math.sin(radians) + (y-ey)*Math.cos(radians)
        r = nx**2/a**2 + ny**2/b**2

        img.pixel_color(x, y, "cmyk(0,0,0,#{255*(1-r)}") if r <= 1
      end
    end

    img
  end
  
  def in_range?(rl, rr, n)
    # First version
    (rl..rr).include?(n) || (rr..rl).include?(n)

    # Second version
    # min, max = rl < rr ? [rl, rr] : [rr, rl]

    # min < n && n <= max

    # Third version
    # (min..max).include?(n)

    # Fourth version
    # n.between?(min, max)
  end

  def check_point(l, p)
    epsilon = 0.001

    # y = a*x + b
    # a = (y2-y1)/(x2-x1)
    a = (l[1][1]-l[0][1])/(l[1][0]-l[0][0])
    # b = y1-(a*x1)
    b = l[0][1]-(a*l[0][0])

    in_range?(l[0][0], l[1][0], p[0]) && in_range?(l[0][1], l[1][1], p[1]) && ((p[1] - (a * p[0] + b)).abs < epsilon)
    # in_range?(l[0][0], l[1][0], p[0]) && ((p[1] - (a * p[0] + b)).abs < epsilon)

    # # Second version
    # x = [l[0][0], l[1][0]]
    # y = [l[0][1], l[1][1]]
    #
    # min_x, max_x = x.minmax
    # min_y, max_y = y.minmax
    #
    # p[0] > min_x && p[0] < max_x && p[1] > min_y && p[1] < max_y
  end

  def intersection(l1, l2)
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

    p = [x,y]

    # check_point(l1, p) && check_point(l2, p)
    # (check_point(l1, p) && check_point(l2, p)) ? p : nil
  end

  def intersection?(l1, l2)
    p = intersection(l1,l2)
    check_point(l1, p) && check_point(l2, p)
  end

  #
  #
  #
  # [[10, 10], [180, 20], [160, 150], [100, 50], [20,180]]
  #
  def polygon(size, points)
    img = Image.new(size, size) { self.background_color = 'white' }

    minx = miny = size
    maxx = maxy = 0

    lines = []
    segments = []
    (0...points.count).each do |i|
      minx = points[i][0] if points[i][0] < minx
      miny = points[i][1] if points[i][1] < miny
      maxx = points[i][0] if points[i][0] > maxx
      maxy = points[i][1] if points[i][1] > maxy

      lines << [points[i], points[i-1]]
      segments << LineIntersection::Segment.from_array(lines[i])
    end

    (minx.to_i..maxx.to_i).each do |x|
      (miny.to_i..maxy.to_i).each do |y|
        # c = lines.count { |l| intersection?(l, [[0,y.to_f],[x.to_f,y.to_f]]) }
        # d = lines.count { |l| intersection(l, [[size.to_f,y.to_f],[x.to_f,y.to_f]]) }
        # img.pixel_color(x-1, (size) - y, 'black') if c.odd? and d.odd?
        # img.pixel_color(x-1, (size) - y, 'black') if c.odd?

        # intersections = lines.map do |l1|
        #   l2 = [[0, y.to_f], [x.to_f, y.to_f]]
        #   p = intersection(l1, l2)
        #   check_point(l1, p) && check_point(l2, p) ? [p[0].to_i, p[1].to_i] : nil
        # end
        #
        # intersections = intersections.compact.uniq
        # img.pixel_color(x-1, (size) - y, 'black') if intersections.odd?

        res = segments.map do |s1|
          s2 = LineIntersection::Segment.from_array([[0, y.to_f], [x.to_f, y.to_f]])
          p = LineIntersection.ll_intersection(s1, s2)
          p.x = p.x.to_i if p
          p.y = p.y.to_i if p
          p
        end

        res.compact!.uniq!
        img.pixel_color(x-1, (size) - y, 'black') if res.count.odd?

        # ps = []
        # lines.each do |l|
        #   p = intersection(l, [[-1.0,-1.0],[x.to_f,y.to_f]])
        #   ps << p if !p.nil? && !ps.include?(p)
        # end
        # img.pixel_color(x-1, (size) - y, 'black') if ps.count.odd?
      end
    end

    img
  end

  #
  #
  #
  def sample_polygon
    polygon(200, [[10.0, 10.0], [180.0, 20.0], [160.0, 150.0], [100.0, 50.0], [20.0,180.0]])
  end

  def sample_polygon2
    polygon(512, [[10.0, 10.0], [432.0, 20.0], [390.0, 154.0], [470.0, 490.0], [50.0, 123.0]])
  end

  module_function :circle_full, :circle_impl, :circle_par, 
    :spiral, :triangle, :ellipse, :polygon, :sample_polygon, :sample_polygon2,
    :intersection, :check_point, :in_range?
end