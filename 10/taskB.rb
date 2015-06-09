require 'csv'
require 'rubygems'
require '../ruby_gnuplot/lib/gnuplot'
require_relative 'k_means'

#
# Main driver for an implementation of the k-means clustering algorithm on simple
# 2D data points read in from a CSV file. Produces graphic output
# showing the clusters found in the input data.
#
if __FILE__ == $0
  include LinearRegresion

  data = []
  filename = ''
  k = 0

  # Argument check
  if ARGV.length == 2
    filename = ARGV[0]
    k =  ARGV[1].to_i
  else
    puts 'Usage: k_means.rb INPUT-FILE NUMBER-OF-CLUSTERS'
    exit
  end

  # Get all data
  CSV.foreach(filename, col_sep: ' ') do |row|
    x = row[0].to_f
    y = row[1].to_f

    p = Point.new(x, y)
    data.push p
  end

  # Run algorithm on data
  clusters = k_means(data, k)

  # Graph output by running gnuplot pipe
  Gnuplot.open do |gp|
    # Start a new plot
    Gnuplot::Plot.new(gp) do |plot|
      plot.title filename

      plot.terminal 'png'
      plot.output "outputs/#{File.basename(filename, '.*')}_plot.png"

      # Plot each cluster's points
      clusters.each do |cluster|
        # Collect all x and y coords for this cluster
        x = cluster.points.collect { |p| p.x }
        y = cluster.points.collect { |p| p.y }

        # Plot w/o a title (clutters things up)
        plot.data << Gnuplot::DataSet.new([x, y]) do |ds|
          ds.notitle
        end
      end
    end
  end
end
