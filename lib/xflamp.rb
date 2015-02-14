require 'xflamp/build_servers'
require 'xflamp/lamp'

module XFLamp
  module_function

  def run
    servers = BuildServers.new
    lamp = Lamp.new
    loop do
      green = servers.green?
      if green
        puts 'All watched builds are well!'
        lamp.off!
      else
        puts 'There is at least one build that is not passing...'
        lamp.on!
      end
      sleep 10
    end
  rescue Interrupt
    puts 'Exiting...'
  end
end

