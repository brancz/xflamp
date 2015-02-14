require 'xflamp/build_servers'

module XFLamp
  module_function

  def main
    servers = BuildServers.new
    lamp = Lamp.new
    loop do
      lamp.on! unless servers.green?
      sleep 10
    end
  rescue
    puts 'Exiting...'
  end
end

