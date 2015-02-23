require 'collatz'
require '../lib/svg/svg'
require '../lib/svg/line'
require '../lib/svg/point'

require '../ruby_gnuplot/lib/gnuplot'

def collatz_max_numbers
  svg_file1 = Svg::Svg.new :width => 500, :height => 300
  svg_file1.add_shape(Svg::Line.new(0, 0, 0, 300))
  svg_file1.add_shape(Svg::Line.new(0, 0, 500, 0))
  svg_file1.add_shape(Svg::Line.new(500, 300, 0, 300))
  svg_file1.add_shape(Svg::Line.new(500, 300, 500, 0))

  (1..500).each { |n| svg_file1.add_shape(Svg::Point.new(n, (10001 - Collatz.new(n).maximum_number)/40 + 50)) }

  svg_file1.doc.write File.new('outputs/collatz_max.svg', 'w')
end

def collatz_max_numbers_plot(format=:svg)
  Gnuplot.open do |gp|
    Gnuplot::Plot.new(gp) do |plot|
      plot.xlabel 'x'
      plot.ylabel 'Collatz maximum number in sequence of x'

      if format == :svg
        plot.terminal 'svg'
        plot.output File.expand_path('outputs/collatz_max_plot.svg', File.dirname(__FILE__))
      elsif format == :png
        plot.terminal 'png'
        plot.output File.expand_path('outputs/collatz_max_plot.png', File.dirname(__FILE__))
      end

      x = (1..500).to_a
      # x = (1..25).to_a
      y = x.collect { |n| Collatz.new(n).maximum_number }

      s = plot.style do |style|
        style.pt = 7
        style.lc = 'rgb "black"'
        style.ps = 0.6
      end

      plot.data << Gnuplot::DataSet.new([x, y]) do |ds|
        ds.with = "points"
        ds.notitle
        ds.ls = s
      end
    end
  end
end

def collatz_steps_plot(format=:svg)
  Gnuplot.open do |gp|
    Gnuplot::Plot.new(gp) do |plot|
      plot.xlabel 'x'
      plot.ylabel 'Collatz number of steps in sequence of x'

      if format == :svg
        plot.terminal 'svg'
        plot.output File.expand_path('outputs/collatz_steps_plot.svg', File.dirname(__FILE__))
      elsif format == :png
        plot.terminal 'png'
        plot.output File.expand_path('outputs/collatz_steps_plot.png', File.dirname(__FILE__))
      end

      x = (1..10000).to_a
      y = x.collect { |n| Collatz.new(n).number_of_steps }

      s = plot.style do |style|
        style.pt = 7
        style.lc = 'rgb "black"'
        style.ps = 0.6
      end

      plot.data << Gnuplot::DataSet.new([x, y]) do |ds|
        ds.with = "points"
        ds.notitle
        ds.ls = s
      end
    end
  end
end

def collatz_steps
  svg_file1 = Svg::Svg.new :width => 500, :height => 300
  svg_file1.add_shape(Svg::Line.new(0, 0, 0, 300))
  svg_file1.add_shape(Svg::Line.new(0, 0, 500, 0))
  svg_file1.add_shape(Svg::Line.new(500, 300, 0, 300))
  svg_file1.add_shape(Svg::Line.new(500, 300, 500, 0))

  (1..10000).each { |n| svg_file1.add_shape(Svg::Point.new(n/20, 301 - Collatz.new(n).number_of_steps)) }

  svg_file1.doc.write File.new('outputs/collatz_steps.svg', 'w')
end

def collatz_sequence_plot(number, format=:svg)
  Gnuplot.open do |gp|
    Gnuplot::Plot.new(gp) do |plot|

      col = Collatz.new(number)

      plot.xlabel "number of steps: #{col.number_of_steps}"
      plot.ylabel "collatz_sequence(#{number})"

      if format == :svg
        plot.terminal 'svg'
        plot.output File.expand_path("outputs/collatz_sequence_#{number}_plot.svg", File.dirname(__FILE__))
      elsif format == :png
        plot.terminal 'png'
        plot.output File.expand_path("outputs/collatz_sequence_#{number}_plot.png", File.dirname(__FILE__))
      end

      s = plot.style do |style|
        style.pt = 7
        style.lc = 'rgb "black"'
        style.ps = 0.6
      end

      plot.data << Gnuplot::DataSet.new([(1..col.number_of_steps).to_a, col.sequence]) do |ds|
        ds.with = "linespoints"
        ds.notitle
        ds.ls = s
      end
    end
  end
end

if __FILE__ == $0
  # collatz_max_numbers
  collatz_max_numbers_plot
  # collatz_steps
  collatz_steps_plot

  collatz_sequence_plot(27)
end
