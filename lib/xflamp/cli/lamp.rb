require 'xflamp/cli/command'

module XFLamp
  module CLI
    class Lamp < Command
      description 'manually turn the lamp "on" or "off"'

      on('-p', '--pin [PIN]', Integer, 'Pin to write io to')

      def run(state)
        lamp = XFLamp::Lamp.new(pin || 0)
        method = {
          'on'  => :on!,
          'off' => :off!
        }.fetch(state)
        lamp.public_send(method)
      rescue KeyError
        puts 'unknown state'
        exit 1
      end
    end
  end
end
