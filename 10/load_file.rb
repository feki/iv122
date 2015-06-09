def get_points_from_file(file)
  File.open(file, 'r') do |f|
    while line = f.gets
      Enumerator.new do |y|
        xy = line.split(' ')
        y << [xy[0], xy[1]]
      end
    end
  end
end