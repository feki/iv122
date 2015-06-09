require 'slim'

task :clean, :dir_name do |t, args|
  dir_name = args[:dir_name] || 'build'
  rm_rf "#{dir_name}/."
end

task :copy_files, :dir_name do |t, args|
  dir_name = args[:dir_name] || 'build'

  mkdir dir_name unless File.exists? dir_name
  mkdir "#{dir_name}/js"
  mkdir "#{dir_name}/css"
  mkdir "#{dir_name}/fonts"
  mkdir "#{dir_name}/img"

  cp 'site/bower_components/bootstrap/dist/css/bootstrap.min.css', "#{dir_name}/css/"
  cp 'site/bower_components/bootstrap/dist/js/bootstrap.min.js', "#{dir_name}/js/"
  cp 'site/bower_components/jquery/dist/jquery.min.js', "#{dir_name}/js/"
  cp_r 'site/bower_components/bootstrap/dist/fonts/.', "#{dir_name}/fonts/"
  cp_r 'site/css/.', "#{dir_name}/css/"
  cp_r 'site/js/.', "#{dir_name}/js/"
  cp_r 'site/img/.', "#{dir_name}/img/"
end

task :build, [:dir_name] => [:clean, :copy_files] do |t, args|
  dir_name = args[:dir_name] || 'build'
  File.open("#{dir_name}/index.html", 'w') { |f| f.write Slim::Template.new('site/index.slim').render }
  File.open("#{dir_name}/1.html", 'w') { |f| f.write Slim::Template.new('site/1.slim').render }
  File.open("#{dir_name}/2.html", 'w') { |f| f.write Slim::Template.new('site/2.slim').render }
  File.open("#{dir_name}/3.html", 'w') { |f| f.write Slim::Template.new('site/3.slim').render }
  File.open("#{dir_name}/4.html", 'w') { |f| f.write Slim::Template.new('site/4.slim').render }
  File.open("#{dir_name}/5.html", 'w') { |f| f.write Slim::Template.new('site/5.slim').render }
  File.open("#{dir_name}/6.html", 'w') { |f| f.write Slim::Template.new('site/6.slim').render }
  File.open("#{dir_name}/7.html", 'w') { |f| f.write Slim::Template.new('site/7.slim').render }
  File.open("#{dir_name}/8.html", 'w') { |f| f.write Slim::Template.new('site/8.slim').render }
  File.open("#{dir_name}/9.html", 'w') { |f| f.write Slim::Template.new('site/9.slim').render }
  File.open("#{dir_name}/10.html", 'w') { |f| f.write Slim::Template.new('site/10.slim').render }
end