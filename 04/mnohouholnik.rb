def polygon(points)
  lines = (0...points.count).collect { |i| [points[i-1], points[i]] }
  min_x, max_x = points.minmax_by { |point| point[0] }
  min_y, max_y = points.minmax_by { |point| point[1] }
end