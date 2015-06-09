require 'thread'
require File.dirname(__FILE__) + '/maze'
require File.dirname(__FILE__) + '/maze_input'

# Rekurzivny backtracking tvori bludisko pomocou randomizovaneho algoritmu vyhladavania do hlbky a backtrakingu.
# Tvori dlhe suvisle cesty.
class RecursiveBacktracking
  attr_accessor :maze, :mutex

  def initialize(maze)
    @maze = maze
    @mutex = Mutex.new
  end

  def generate()
    @maze.reset_maze
    recursion_n(@maze.ends)
  end

  def recursion(point)
    @mutex.lock
    @maze.maze_grid[point[0]][point[1]].visited = true
    @mutex.unlock
    order = Maze::DIRECTIONS.sort_by{rand}
    order.each do |direction|
      next_point = point
      @mutex.lock
      if @maze.maze_grid[point[0]][point[1]].walls[direction] && (@maze.maze_grid[point[0]+Maze::MOVE[direction][0]][point[1]+Maze::MOVE[direction][1]].visited == false)
        @maze.maze_grid[point[0]][point[1]].walls[direction] = false
        @maze.maze_grid[point[0]+Maze::MOVE[direction][0]][point[1]+Maze::MOVE[direction][1]].walls[Maze::OPPOSITE[direction]] = false
        @maze.maze_grid[point[0]+Maze::MOVE[direction][0]][point[1]+Maze::MOVE[direction][1]].visited = true
        next_point = [point[0]+Maze::MOVE[direction][0],point[1]+Maze::MOVE[direction][1]]
      end
      @mutex.unlock
      if next_point != point
        recursion(next_point)
      end
    end
  end

  def recursion_n(points)
    points.each do |point|
      @maze.maze_grid[point[0]][point[1]].visited = true
    end

    @mutex.lock
    threads = []
    points.each do |point|
      threads << Thread.new(point) {
        recursion(point)
      }
    end
    @mutex.unlock

    threads.each { |aThread|  aThread.join }
  end

  public :generate
  private :recursion, :recursion_n
end

if __FILE__ == $0
  filename = ARGV.delete_at(0)

  mi = MazeInput.new
  maze = mi.get_maze #Maze.new(50,50,[0,0],[[49,49],[0,49],[49,0]])
  alg = RecursiveBacktracking.new(maze)
  alg.generate()
  maze.braid()
  # maze.create_svg('outputs/RecursiveBacktracking.svg')
  maze.create_svg("outputs/#{filename}.svg")
end
