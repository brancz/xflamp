require 'xflamp/build_servers'
require 'xflamp/travis'
require 'xflamp/lamp'
require 'xflamp/cli/command'

module XFLamp
  class CLI
    class Watch < Command
      def run
        config.load
        servers = config.servers
        lamp = Lamp.new options.pin
        loop do
          if servers.green?
            puts 'All watched builds are well!' if options.verbose
            lamp.off!
          else
            puts 'There is at least one build that is not passing...' if options.verbose
            lamp.on!
          end
          break if options.once?
          sleep 10
        end
      end
    end
  end
end
