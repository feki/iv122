#
# k_means.rb - an implementation of the k-means clustering algorithm on simple
#              2D data points read in from a CSV file. Produces graphic output
#              showing the clusters found in the input data.
#
module LinearRegresion

  #
  # Point class, for representing a coordinate in 2D space
  #
  class Point
    attr_accessor :x, :y

    #
    # Constructor that takes in an x,y coordinate
    #
    def initialize(x, y)
      @x = x
      @y = y
    end

    #
    # Calculates the distance to Point p
    #
    def dist_to(p)
      xs = (@x - p.x)**2
      ys = (@y - p.y)**2
      Math::sqrt(xs + ys)
    end

    #
    # Return a String representation of the object
    #
    def to_s
      "[#{@x},#{@y}]"
    end
  end

  #
  # Cluster class, represents a centroid point along with its associated
  # nearby points
  #
  class Cluster
    attr_accessor :center, :points

    #
    # Constructor with a starting center point
    #
    def initialize(center)
      @center = center
      @points = []
    end

    #
    # Recenters the centroid point and removes all of the associated points
    #
    def recenter!
      xa = ya = 0
      old_center = @center

      # Sum up all x/y coords
      @points.each do |point|
        xa += point.x
        ya += point.y
      end

      # Average out data
      xa /= points.length
      ya /= points.length

      # Reset center and return distance moved
      @center = Point.new(xa, ya)
      old_center.dist_to(center)
    end
  end

  #
  # k-means algorithm
  #
  def k_means(data, k, delta=0.001)
    clusters = []

    # Assign initial values for all clusters
    (1..k).each do |point|
      index = (data.length * rand).to_i

      rand_point = data[index]
      c = Cluster.new(rand_point)

      clusters.push c
    end

    # Loop
    while true
      # Assign points to clusters
      data.each do |point|
        # Find the closest cluster
        # and Add to closest cluster
        clusters.min_by { |c| point.dist_to(c.center) }
            .points.push point
      end

      # Check deltas
      max_delta =  clusters.collect { |c| c.recenter! }.max

      # Check exit condition
      if max_delta < delta
        return clusters
      end

      # Reset points for the next iteration
      clusters.each do |cluster|
        cluster.points = []
      end
    end
  end

end
