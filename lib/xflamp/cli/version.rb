require 'xflamp/cli/command'

module XFLamp
  module CLI
    class Version < Command
      description 'print version info'

      def run
        puts 'Printing le version'
      end
    end
  end
end
