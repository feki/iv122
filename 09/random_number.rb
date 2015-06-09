require_relative '../ruby_gnuplot/lib/gnuplot'

module ProbabilityAndStatistics
  #
  #
  #
  def generate_histogram_to_file(data, filename)

    puts data
    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|

        plot.title 'Histogram'
        # plot.style 'data histogram'

        plot.terminal 'png'
        plot.output filename

        x = data.first
        y = data.last

        plot.data << Gnuplot::DataSet.new([x, y]) do |ds|
          ds.smooth = 'freq'
          ds.with = 'boxes'
        end

      end
    end

  end

  #
  #
  #
  def load_dice_rolls_from_file(filename)
    frequency = {}
    open(filename, 'r') do |f|
      rolls = f.gets.split(' ')

      frequency = rolls.group_by { |roll| roll }
    end

    keys = frequency.keys.sort
    values = keys.collect { |key| frequency[key] }

    [keys, values]
  end

  #
  #
  #
  def generate_histogram(data_filename, histogram_filename)
    data = load_dice_rolls_from_file(data_filename)
    generate_histogram_to_file(data, histogram_filename)
  end

  #
  #
  #
  def pearsonChiSquaredTest(data)
    n = data.last.reduce(:+)
    p_i = 1.0/data.first.length
    e_i = n*p_i

    # compute chi
    chi = data.first.reduce(0) { |mem, o| mem += (o - e_i) ** 2 / e_i }


    chi_5_0_95
  end
end

if $0 == __FILE__
  include ProbabilityAndStatistics

  names = (1..7).to_a.collect { |i| "random#{i}" }
  txt = names.collect { |name| "#{name}.txt" }
  out = names.collect { |name| "#{name}.png" }
  (0...7).each do |i|
    generate_histogram("random/#{txt[i]}", "outputs/#{out[i]}")
  end
end
