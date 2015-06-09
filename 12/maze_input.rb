require File.dirname(__FILE__) + '/maze'
require File.dirname(__FILE__) + '/ruby_goto/goto'

# Trieda poskytujuca moznost uzivatelskych vsupov o bludisku
class MazeInput
  attr_reader :width, :height, :start_p, :end_p

  # postupne vola metody na ziskanie informacii o bludisku od uzivatela
  def initialize()
    get_dimensions()
    get_start_p()
    get_end_p()
  end

  def convert_s_array_to_i_array(s_array)
	  i_array = []
    raise(ArgumentError) if s_array.length < 2
	  for i in 0...2 do
      raise(ArgumentError) if not( /^[\d]+$/ === s_array[i] )
	  	i_array << s_array[i].to_i
	  end
	  i_array
  end

  # metoda ziska informacie o rozmeroch bludiska
  def get_dimensions()
    frame_start
      label(:a) do
        puts "Zadaj veľkosť bludiska (rozmery musia byť vačšie ako 0): X Y"
        begin
          @width, @height = convert_s_array_to_i_array(gets.split(" "))
          raise(ArgumentError) if @width <= 0 or @height <= 0
        rescue ArgumentError
          puts "Chybný vstup. Skús znova.\n"

          # znovu nacitanie vstupu
          goto :a
        end
      end
    frame_end
  end

  # metoda ziska informacie o startovacom bode bludiska
  def get_start_p()
    frame_start
      label(:a) do
        puts "Zadaj pociatocny bod: X(0-#{@width-1}) Y(0-#{@height-1})"
        begin
          @start_p = convert_s_array_to_i_array(gets.split(" "))
          raise(ArgumentError) if @start_p[0] < 0 or @start_p[0] >= @width or @start_p[1] < 0 or @start_p[1] >= @height
        rescue ArgumentError
          puts "Chybný vstup. Skús znova.\n"

          # znovu nacitanie vstupu
          goto :a
        end
      end
    frame_end
  end

  # metoda ziska informacie o koncovom bode alebo koncovych bodov (v pripade ze sa jedna o recursive backtracking
  # algoritmus) bludiska
  def get_end_p()
    @end_p = []
    frame_start
      begin
        Module::const_get 'RecursiveBacktracking' # ak je symbol dostupny, predpoklada ze sa jedna o generaciu bludiska
                                                  # pomocou recursive backtracking algoritmu a nacita viac cielov
        label(:na) do
          puts "Zadaj pocet koncovich bodov:"
          number = gets.to_i
          if number <= 0
            puts "Záporný počet cielových bodov nieje povolený, musí byť aspoň jeden. Skús znova.\n"

            # znovu nacitanie vstupu
            goto :na
          end
        end
        for i in 1..number
          label(:ea) do
	          puts "Zadaj #{i}. koncovy bod: X(0-#{@width-1}) Y(0-#{@height-1})"
	          begin
              @end_p << convert_s_array_to_i_array(gets.split(" "))
              raise(ArgumentError) if @end_p[i][0] < 0 or @end_p[i][0] >= @width or @end_p[i][1] < 0 or @end_p[i][1] >= @height
            rescue ArgumentError
              puts "Chybný vstup. Skús znova.\n"

              # znovu nacitanie vstupu
              goto :ea
            end
          end
        end
      rescue NameError
        label(:a) do
          puts "Zadaj koncovy bod: X(0-#{@width-1}) Y(0-#{@height-1})"
	        begin
            @end_p << convert_s_array_to_i_array(gets.split(" "))
            raise(ArgumentError) if @end_p[0][0] < 0 or @end_p[0][0] >= @width or @end_p[0][1] < 0 or @end_p[0][1] >= @height
          rescue ArgumentError
            puts "Chybný vstup. Skús znova.\n"

            # znovu nacitanie vstupu
            goto :a
          end
        end
      end
    frame_end
  end

  # vrati instanciu triedy Maze na zaklade ziskanych informacii
  def get_maze(full=true)
    Maze.new(@width, @height, @start_p, @end_p, full)
  end

  private :convert_s_array_to_i_array
end
