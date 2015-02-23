require 'slim'

task :clean do
  rm_rf 'build/.'
end

task :copy_files do
  mkdir 'build' unless File.exists? 'build'
  mkdir 'build/js'
  mkdir 'build/css'
  mkdir 'build/fonts'
  mkdir 'build/img'

  cp 'site/bower_components/bootstrap/dist/css/bootstrap.min.css', 'build/css/'
  cp 'site/bower_components/bootstrap/dist/js/bootstrap.min.js', 'build/js/'
  cp 'site/bower_components/jquery/dist/jquery.min.js', 'build/js/'
  cp_r 'site/bower_components/bootstrap/dist/fonts/.', 'build/fonts/'
  cp_r 'site/css/.', 'build/css/'
  cp_r 'site/js/.', 'build/js/'
  cp_r 'site/img/.', 'build/img/'
end

task :build => [:clean, :copy_files] do
  File.open('build/index.html', 'w') { |f| f.write Slim::Template.new('site/index.slim').render }
  File.open('build/1.html', 'w') { |f| f.write Slim::Template.new('site/1.slim').render }
end