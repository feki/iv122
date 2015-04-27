require_relative 'pi'

def print_pi(params)
  puts "PI = #{params[:pi]} (Delta: #{Math::PI - params[:pi]}), Elapsed seconds = #{params[:elapsed_time]}"
end

if __FILE__ == $0
  seconds = 2

  pi = Pi.new
  puts 'Monte Carlo method:'
  print_pi(pi.mcm_time(seconds))
  puts
  puts 'Gregory-Leibniz series'
  print_pi(pi.gls_time(seconds))
  puts
  puts 'Nilakantha series'
  print_pi(pi.ns_time(seconds))
  puts
  puts 'Archimedes method'
  print_pi(pi.as_time(seconds))
end