require 'xflamp/build_servers'
require 'xflamp/travis'
require 'xflamp/lamp'
require 'xflamp/cli/command'

module XFLamp
  module CLI
    class Watch < Command
      description 'watch the configured builds'

      on('-p', '--pin [PIN]', Integer, 'Pin to write io to')
      on('-o', '--once', 'Only request the build status once')

      def run
        config.load
        servers = config.servers
        lamp = XFLamp::Lamp.new(pin || 0)
        loop do
          if servers.green?
            puts 'All watched builds are passing!'
            lamp.off!
          else
            puts 'There is at least one build that is not passing...'
            lamp.on!
          end
          break if once?
          sleep 10
        end
      end
    end
  end
end
