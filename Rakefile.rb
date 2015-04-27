task :svg2png, :svg_file_name, :width, :height do |t ,args|
  svg = args[:svg_file_name]
  png = svg.gsub('.svg', '.png')
  width = args[:width] || 1024
  height = args[:height] || 1024
  cmd = "inkscape -z -e #{png} -w #{width} -h #{height} #{svg}"
  `#{cmd}`
end