require 'xflamp/cli/command'
require 'xflamp/version'

module XFLamp
  module CLI
    class Version < Command
      description 'print version info'

      def run
        puts "XFLamp #{XFLamp::VERSION}"
      end
    end
  end
end
