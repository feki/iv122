# class Integer
#   def fact
#     (1..self).reduce(:*) || 1
#   end
# end

# Pascal's triangle: 
# 
#           1
#          /+\
#         1   1
#        /+\ /+\
#       1   2   1
#      /+\ /+\ /+\
#     1   3   3   1
#    /+\ /+\ /+\ /+\
#   1   4   6   4   1
#  /+\ /+\ /+\ /+\ /+\
# 1   5   10  10  5   1
class PascalTriangle
  def initialize(height)
    @height = height
  end

  def pascal_triangle
    return if @height < 1

    tria = [[1]]
    n = @height

    while n > 1
      tria2 = [1, 1]
      tria1 = tria.last
      if tria1.count > 1
        for i in (tria1.count-2).downto(0)
          tria2.insert(1, tria1[i] + tria1[i+1])
        end
      end

      n -= 1
      tria << tria2
    end

    tria
  end
end
