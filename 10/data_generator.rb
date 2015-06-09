class Point < Struct.new(:x, :y); end

def get_random_point(max_x = nil, max_y = nil)
  x = max_x.nil? ? rand : rand(max_x)
  y = max_y.nil? ? rand : rand(max_y)

  Point.new(x, y)
end

def get_random_point_around_point(x, y, ax, ay)
  p = get_random_point()
end