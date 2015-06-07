module ConvexHull

  def cross(o, a, b)
    (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x)
  end

  #
  # It computes convex hull using Gift wrapping algorithm (aka Jarvis march)
  #
  def gift_wrapping(points)
    points.sort! do |p1, p2|
      p1.x != p2.x ? p1.x <=> p2.x : p1.y <=> p2.y
    end.uniq!

    return points if points.length < 3

    lower = Array.new
    points.each{|p|
      while lower.length > 1 and cross(lower[-2], lower[-1], p) <= 0 do
        lower.pop
      end
      lower.push(p)
    }

    upper = Array.new
    points.reverse_each{|p|
      while upper.length > 1 and cross(upper[-2], upper[-1], p) <= 0 do
        upper.pop
      end
      upper.push(p)
    }

    return lower[0...-1] + upper[0...-1]
  end

  module_function :gift_wrapping, :cross
end