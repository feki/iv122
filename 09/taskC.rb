require_relative 'central_limit_theorem'

if $0 == __FILE__
  include ProbabilityAndStatistics

  open('outputs/hist1.txt', 'w') do |f|
    generate_histogram_data { ka_cube }.each do |avg|
      f.write "#{avg} "
    end
  end

  open('outputs/hist2.txt', 'w') do |f|
    generate_histogram_data { choose_and_roll }.each do |avg|
      f.write "#{avg} "
    end
  end

  open('outputs/hist3.txt', 'w') do |f|
    generate_histogram_data { choose_cube.call }.each do |avg|
      f.write "#{avg} "
    end
  end
end