# It reads data from file, data format is a pair of values (x,y) on single line separate by whitespace.
# Example of data file:
#   3.2192842317151764 9.3044544565773464
#   -8.8404951514257011 8.9728313670142423
#   -10.58039992945535 5.4184569789524479
#   12.427087800781591 0.75266840276826019
#   ...
# @param [String, File] file open file (instance of File class) or filename
# @return [Array] returns array of [x, y], which is pair of Arrays, where
#   x is array of values in first column and y is array of values in second column
def read_data(file)
  f = file.is_a?(File) ? file : File.new(file, 'r')
  x, y = [], []

  f.readlines.each do |line|
    _x, _y = line.split(' ')
    x << _x.to_f
    y << _y.to_f
  end
  f.close unless file.is_a?(File)

  [x, y]
end

if __FILE__ == $0
  require '../ruby_gnuplot/lib/gnuplot'

  make_plot = lambda do |filename, format|
    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|

        if format == :svg
          plot.terminal 'svg'
          plot.output "outputs/#{filename}_plot.svg"
        elsif format == :png
          plot.terminal 'png'
          plot.output "outputs/#{filename}_plot.png"
        end

        s = plot.style do |style|
          style.pt = 7
          style.lc = 'rgb "black"'
          style.ps = 0.6
        end

        plot.data << Gnuplot::DataSet.new(read_data("#{filename}.txt")) do |ds|
          ds.with = "points"
          ds.notitle
          ds.ls = s
        end
      end
    end
  end

  make_plot.call('cluster_data', :svg)
  make_plot.call('cluster_data', :png)
  make_plot.call('faithful', :svg)
  make_plot.call('faithful', :png)
  make_plot.call('linreg', :svg)
  make_plot.call('linreg', :png)
end
