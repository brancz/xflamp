require 'xflamp/build_servers'
require 'xflamp/travis'
require 'xflamp/lamp'
require 'xflamp/cli/command'

module XFLamp
  class CLI
    class Watch < Command
      def run
        servers = BuildServers.new config.servers
        lamp = Lamp.new options.pin
        loop do
          if servers.green?
            puts 'All watched builds are well!'
            lamp.off!
          else
            puts 'There is at least one build that is not passing...'
            lamp.on!
          end
          sleep 10
        end
      rescue XFLamp::Config::ConfigMissing
        puts 'The config you intend to use does not exists. By default XFLamp uses the file `xflamp.yml` in the current directory.'
      rescue Interrupt
        puts 'Exiting...'
      end
    end
  end
end
