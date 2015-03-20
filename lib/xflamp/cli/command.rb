require 'ostruct'
require 'xflamp/config'

module XFLamp
  class CLI
    class Command
      def initialize(options)
        @options = options
      end

      def options
        OpenStruct.new(@options)
      end

      def config
        @config ||= XFLamp::Config.new options.config_path
      end
    end
  end
end
