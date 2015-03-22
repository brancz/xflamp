require 'xflamp/cli/command'

module XFLamp
  module CLI
    class Help < Command
      description 'print help info'

      def run(command = nil)
        if command
          puts CLI.command(command).new.help
        else
          puts "Usage: xflamp COMMAND ...\n\nAvailable commands:\n\n"
          commands.each { |c| puts "\t#{c.command_name.ljust(22)} #{c.description}" }
          puts "\nrun `#$0 help COMMAND` for more infos"
        end
      end

      def commands
        CLI.commands.sort_by { |c| c.command_name }
      end
    end
  end
end
