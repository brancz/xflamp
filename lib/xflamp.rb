require 'xflamp/build_servers'
require 'xflamp/lamp'

module XFLamp
  module_function

  def run(options = {})
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
  rescue Config::ConfigMissing
    puts 'The config you intend to use does not exists. By default XFLamp uses the file xflamp.yml in the current directory.'
  rescue Interrupt
    puts 'Exiting...'
  end
end

