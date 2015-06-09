require 'csv'

require_relative 'k_means'
require_relative '../ruby_gnuplot/lib/gnuplot'

module LinearRegresion
  def batch_gradient_descent(iterations, alpha, dataset)
    a = 1
    b = 0

    iterations.times do
      # Compute the gradients first, to update variables at once
      gradient_a = dataset.collect { |p| p.x * (p.y - a * p.x - b) }.reduce(:+)
      gradient_b = dataset.collect { |p| p.y - a * p.x - b }.reduce(:+)

      a += alpha * gradient_a
      b += alpha * gradient_b
    end
    return [a, b]
  end

  def read_dataset(filename)
    points = []

    CSV.foreach(filename, col_sep: ' ') do |row|
      x = row[0].to_f
      y = row[1].to_f

      p = Point.new(x, y)
      points.push p
    end

    points
  end


  def plot_linear_regression(dataset)
    a, b = batch_gradient_descent(10000, 0.0001, dataset)

    x_data = dataset.collect { |p| p.x }
    y_data = dataset.collect { |p| p.y }

    min_x = x_data.min
    max_x = x_data.max

    # print a, b

    # plt.plot([p.x for p in dataset], [p.y for p in dataset], 'ro')
    #                                       plt.plot([min_x, max_x], [a * min_x + b, a * max_x + b])
    #                                       plt.show()
    # Graph output by running gnuplot pipe
    Gnuplot.open do |gp|
      # Start a new plot
      Gnuplot::Plot.new(gp) do |plot|
        # plot.title filename

        # plot.terminal 'png'
        # plot.output "outputs/#{File.basename(filename, '.*')}_plot.png"

        # Plot each cluster's points
        # clusters.each do |cluster|
        #   # Collect all x and y coords for this cluster
        #   x = cluster.points.collect { |p| p.x }
        #   y = cluster.points.collect { |p| p.y }
        #
        #   # Plot w/o a title (clutters things up)
        #   plot.data << Gnuplot::DataSet.new([x, y]) do |ds|
        #     ds.notitle
        #   end
        # end

        plot.data << Gnuplot::DataSet.new([x_data, y_data]) do |ds|
          ds.notitle
        end

        plot.data << Gnuplot::DataSet.new("#{a}*x+#{b}") do |ds|
          ds.notitle
        end
      end
    end
  end
end

include LinearRegresion

if $0 == __FILE__
  data = read_dataset('linreg.txt')
  plot_linear_regression(data)

  data = read_dataset('faithful.txt')
  plot_linear_regression(data)
end
