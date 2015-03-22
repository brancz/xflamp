require 'ostruct'
require 'xflamp/config'
require 'xflamp/cli/parser'

module XFLamp
  module CLI
    class Command
      extend Parser

      on('-h', '--help', 'display help') do |c, _|
        puts c.help
        exit
      end

      on('-c', '--config-path [CONFIG]', 'config file to use')

      attr_reader :arguments, :config

      def initialize
        @arguments = []
      end

      def execute
        check_arity(method(:run), *arguments)
        run(*arguments)
      end

      def parse(args)
        rest = parser.parse(args)
        @arguments.concat(rest)
      rescue OptionParser::ParseError => e
        puts e.message
      end

      def config
        @config ||= XFLamp::Config.new(config_path || 'xflamp.yml')
      end

      def help(info = "")
        parser.banner = usage
        self.class.description.sub(/./) { |c| c.upcase } + ".\n\n" + info + parser.to_s
      end

      def command_name
        self.class.command_name
      end

      def usage
        "Usage: " << usage_for(command_name, :run)
      end

      def usage_for(prefix, method)
        usage = "xflamp #{prefix}"
        method = method(method)
        if method.respond_to? :parameters
          method.parameters.each do |type, name|
            name = name.upcase
            name = "[#{name}]"   if type == :opt
            name = "[#{name}..]" if type == :rest
            usage << " #{name}"
          end
        elsif method.arity != 0
          usage << " ..."
        end
        usage << " [OPTIONS]"
      end

      def check_arity(method, *args)
        return unless method.respond_to? :parameters
        method.parameters.each do |type, name|
          return if type == :rest
          wrong_args("few") unless args.shift or type == :opt or type == :block
        end
        wrong_args("many") if args.any?
      end

      def wrong_args(quantity)
        puts "too #{quantity} arguments\n"
        puts help
        exit 1
      end

      def self.abstract?
        XFLamp::CLI::Command == self
      end

      def self.command_name
        name[/[^:]*$/].split(/(?=[A-Z])/).map(&:downcase).join('-')
      end

      def self.description(description = nil)
        @description = description if description
        @description ||= ""
      end
    end
  end
end
