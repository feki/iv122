module Maze
  #
  #
  #
  class Vertex
    attr_accessor :x, :y, :dist, :prev

    def to_s
      "[#{@x},#{@y}]"
    end
  end

  #
  #
  #
  class Edge
    attr_accessor :from, :to, :weight
  end

  #
  #
  #
  class Graph
    attr_accessor :vertices, :edges, :size, :maze

    #
    #
    #
    def initialize
      @vertices = []
      @edges = []
    end

    #
    #
    #
    def self.from_number_maze(maze)
      g = Graph.new
      g.maze = maze
      g.size = [maze.length, maze.first.length]
      maze.each_with_index do |row, i_row|
        row.each_with_index do |column, j_column|
          v = Vertex.new
          v.x = i_row
          v.y = j_column
          g.vertices.push v
        end
      end

      g.vertices.each do |v|
        weight = maze[v.x][v.y]

        if v.x + weight < g.size[0]
          e = Edge.new
          e.weight = weight
          e.from = v
          e.to = g.get_vertex(v.x + weight, v.y)
          g.edges.push e
        end

        if v.x - weight >= 0
          e = Edge.new
          e.weight = weight
          e.from = v
          e.to = g.get_vertex(v.x - weight, v.y)
          g.edges.push e
        end

        if v.y + weight < g.size[1]
          e = Edge.new
          e.weight = weight
          e.from = v
          e.to = g.get_vertex(v.x, v.y + weight)
          g.edges.push e
        end

        if v.y - weight >= 0
          e = Edge.new
          e.weight = weight
          e.from = v
          e.to = g.get_vertex(v.x, v.y - weight)
          g.edges.push e
        end
      end

      g
    end

    #
    #
    #
    def get_vertex(x, y)
      @vertices.select { |v| v.x == x && v.y == y }.first
    end

    #
    #
    #
    def get_edges_from(x, y)
      get_edges_from_vertex get_vertex(x, y)
    end

    #
    #
    #
    def get_edges_from_vertex(v)
      @edges.select { |e| e.from == v }
    end

    #
    #
    #
    def get_edge(from, to)
      @edges.select { |e| e.from == from && e.to == to }.first
    end

    #
    #
    #
    def dijkstra(source_vertex)
      return if @dijkstra_source == source_vertex
      q = @vertices
      q.each do |v|
        v.dist = Float::INFINITY
        v.prev = nil
      end

      source_vertex.dist = 0
      until q.empty?
        # nearest vertex
        u = q.min_by { |v| v.dist }
        break if u.dist == Float::INFINITY
        # delete from queue
        q.delete(u)

        neighbours = get_edges_from_vertex(u).collect { |e| e.to }
        neighbours.each do |v|
          if q.include?(v)
            alt = u.dist + get_edge(u, v).weight
            if alt < v.dist
              v.dist = alt
              v.prev = u
            end
          end
        end
      end

      @dijkstra_source = source_vertex
    end

    #
    #
    #
    def shortest_path(source, target)
      dijkstra(source)
      path = []
      u = target
      while u
        path.unshift(u)
        u = u.prev
      end

      [path, target.dist]
    end

    #
    #
    #
    def maze_to_s
      @maze.collect { |row| row.join(' ') }.join("\n")
    end
  end

  #
  #
  #
  def maze_to_graph

  end

  #
  #
  #
  def load_number_mazes_from_file(filename)
    res = []

    open(filename, 'r') do |f|
      while not f.eof?
        maze_size = f.gets.to_i
        maze = []
        maze_size.times do
          maze.push(f.gets.split.collect { |mv| mv.to_f })
        end

        res.push Graph.from_number_maze(maze)

        f.gets
      end
    end

    res
  end
end

include Maze

if $0 == __FILE__
  load_number_mazes_from_file('ciselne-bludiste.txt').each do |g|
    source = g.get_vertex(0, 0)
    target = g.get_vertex(g.size[0]-1, g.size[1]-1)

    path, distance = g.shortest_path(source, target)

    puts g.maze_to_s
    puts "Solution: #{path.join(' -> ')} of distance: #{distance}"
    puts
  end
end
