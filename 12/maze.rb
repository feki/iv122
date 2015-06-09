class Box
  attr_accessor :walls, :visited, :marked

  def initialize(full)
    @walls =  { "U" => full, "D" => full, "L" => full, "R" => full }
    @visited = false
    @marked = false
  end
end

class Maze
  attr_accessor :maze_grid, :start, :ends, :width, :height

  DIRECTIONS = [ "U", "D", "L", "R" ]
  OPPOSITE = {"U" => "D", "D" => "U", "L" => "R", "R" => "L"}
  MOVE = {"U" => [-1, 0], "D" => [1,0], "L" => [0,-1], "R" => [0,1]}

  def initialize(width, height, start, ends, full=true)

    @width, @height = width, height

    @maze_grid = Array.new(width){ Array.new(height) }
    @start = start
    @ends = ends

    for i in 0...width
      for j in 0...height
        @maze_grid[i][j] = Box.new(full)
        if i == 0
          @maze_grid[i][j].walls["U"] = false
        end
        if j == 0
          @maze_grid[i][j].walls["L"] = false
        end
        if i == width-1
          @maze_grid[i][j].walls["D"] = false
        end
        if j == height-1
          @maze_grid[i][j].walls["R"] = false
        end
      end
    end

  end

  def reset_maze()
    initialize(@width, @height, @start, @ends)
  end

  def generate(maze_algorithm)
    maze_algorithm.call(@maze_grid)
  end

  def braid
    for i in 0...@width
      for j in 0...@height
        if i == 0
          @maze_grid[i][j].walls["U"] = true
        end
        if j == 0
          @maze_grid[i][j].walls["L"] = true
        end
        if i == @width-1
          @maze_grid[i][j].walls["D"] = true
        end
        if j == @height-1
          @maze_grid[i][j].walls["R"] = true
        end
      end
    end

    for i in 0...@width
      for j in 0...@height
        if DIRECTIONS.count { |d| @maze_grid[i][j].walls[d] } >= 3
          try_to_remove_one_wall(i,j)
        end
      end
    end
  end

  def try_to_remove_one_wall(i, j)
    if @maze_grid[i][j].walls["U"] and i > 0
      @maze_grid[i][j].walls["U"] = false
      @maze_grid[i-1][j].walls["D"] = false
      return
    end

    if @maze_grid[i][j].walls["L"] and j > 0
      @maze_grid[i][j].walls["L"] = false
      @maze_grid[i][j-1].walls["R"] = false
      return
    end

    if @maze_grid[i][j].walls["D"] and i < @width-1
      @maze_grid[i][j].walls["D"] = false
      @maze_grid[i+1][j].walls["U"] = false
      return
    end

    if @maze_grid[i][j].walls["R"] and j < @width-1
      @maze_grid[i][j].walls["R"] = false
      @maze_grid[i][j+1].walls["L"] = false
      return
    end
  end

  def put_line(start_point,end_point,file)
    file.puts %Q[<line x1="#{start_point[0]}" y1="#{start_point[1]}" x2="#{end_point[0]}" y2="#{end_point[1]}" stroke="black" stroke-width="1"/>\n]
  end

  def gen_start_ends(file)
    file.puts %Q[<circle cx="#{@start[0]*10+5}" cy="#{@start[1]*10+5}" r="2.5" fill="blue" stroke="blue" stroke-width="1" />\n]
    for i in 0...@ends.length
      file.puts %Q[<circle cx="#{@ends[i][0]*10+5}" cy="#{@ends[i][1]*10+5}" r="2.5" fill="red" stroke="red" stroke-width="1" />\n]
    end
  end

  def put_border_lines(file)
    put_line([0,0],[0,(@maze_grid[0].length)*10],file)
    put_line([0,0],[(@maze_grid.length)*10,0],file)
    put_line([(@maze_grid.length)*10,0],[(@maze_grid.length)*10,(@maze_grid[0].length)*10],file)
    put_line([0,(@maze_grid[0].length)*10],[(@maze_grid.length)*10,(@maze_grid[0].length)*10],file)
  end

  def create_svg(path)
    file = File.new(path, "w")
    file.puts %Q[<?xml version="1.0" encoding="iso-8859-1" standalone="no"?>\n
      <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/SVG/DTD/svg10.dtd">\n
      <svg width="#{@width*10}" height="#{@height*10}" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">\n]

    for x in 0...@maze_grid.length
      for y in 0...@maze_grid[x].length
        if @maze_grid[x][y].walls["U"]
          put_line([x*10,y*10],[x*10,y*10+10],file)
        end
        if @maze_grid[x][y].walls["D"]
          put_line([x*10+10,y*10],[x*10+10,y*10+10],file)
        end
        if @maze_grid[x][y].walls["L"]
          put_line([x*10,y*10],[x*10+10,y*10],file)
        end
        if @maze_grid[x][y].walls["R"]
          put_line([x*10,y*10+10],[x*10+10,y*10+10],file)
        end
      end
    end
    put_border_lines(file)
    gen_start_ends(file)
    file.puts %Q[</svg>\n]
    file.close()
  end

  private :put_line, :put_border_lines, :gen_start_ends
end