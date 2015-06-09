require_relative '../ruby_gnuplot/lib/gnuplot'
require 'pp'

def feigenbaum_diagram(r, y, scale, filename)
  r_diff = (r[1]-r[0]).to_f / scale

  res_x = []
  res_y = []

  scale.times do |i|
    tmp_r = r[0] + i * r_diff
    s = rand
    500.times do |j|
      s = 4 * tmp_r * s * (1-s)
      unless j < 100
        res_x.push tmp_r
        res_y.push s
      end
    end
  end

  Gnuplot.open do |gp|
    Gnuplot::Plot.new(gp) do |plot|
      # plot.xlabel 'x'
      # plot.ylabel 'y'

      plot.terminal 'png'
      plot.output "outputs/#{filename}.png"

      plot.xrange "[#{r.min}:#{r.max}]"
      plot.yrange "[#{y.min}:#{y.max}]"

      s = plot.style do |style|
        # style.pt = 7
        style.lc = 'rgb "black"'
        style.ps = 0.1
      end

      plot.data << Gnuplot::DataSet.new([res_x, res_y]) do |ds|
        ds.with = "points"
        ds.notitle
        ds.ls = s
      end
    end
  end
end

if $0 == __FILE__
  feigenbaum_diagram([0,1], [0,1], 2000, 'feigenbaum_diagram.0x1.0x1.2000')
  feigenbaum_diagram([0.75,1], [0.25,0.75], 2000, 'feigenbaum_diagram.0.75x1.0.25x0.75.2000')
  feigenbaum_diagram([0.85,1], [0.75,1], 2000, 'feigenbaum_diagram.0.85x1.0.75x1.2000')
  feigenbaum_diagram([0.85,1], [0.85,1], 2000, 'feigenbaum_diagram.0.85x1.0.85x1.2000')
  feigenbaum_diagram([0.85,0.95], [0.3,0.4], 2000, 'feigenbaum_diagram.0.85x0.95.0.3x0.4.2000')
  feigenbaum_diagram([0.88,0.92], [0.85,0.95], 2000, 'feigenbaum_diagram.0.85x0.92.0.85x0.95.2000')
end