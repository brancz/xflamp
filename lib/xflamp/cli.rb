require 'optparse'
require 'xflamp/cli/watch'
require 'xflamp/cli/config'

module XFLamp
  class CLI
    attr_accessor :command_to_execute, :options

    def initialize(args)
      @options = options_by(args)
      @command_to_execute = args.shift
    end

    def run
      command_class = find_command command_to_execute
      command = command_class.new options
      command.run
    end

    private

    def options_by(args)
      options = default_options
      OptionParser.new do |opts|
        opts.banner = 'Usage: xflamp [options]'

        opts.on('-p', '--pin [PIN]', Integer, 'Pin to write to when there is a non passing build') do |pin|
          options[:pin] = pin
        end

        opts.on('-c', '--config [CONFIG]', Integer, 'Config file to use') do |config_path|
          options[:config_path] = config_path
        end
      end.parse!
      options
    end

    def find_command(command_name)
      commands = {
        'watch'  => Watch,
        'config' => Config
      }
      commands.fetch(command_name)
    rescue KeyError
      puts 'command not found'
      exit
    end

    def default_options
      {
        :pin => 0,
        :config_path => 'xflamp.yml'
      }
    end
  end
end

