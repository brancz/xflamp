module XFLamp
  module CLI
    autoload :Command, 'xflamp/cli/command'
    autoload :Config,  'xflamp/cli/config'
    autoload :Help,    'xflamp/cli/help'
    autoload :Version, 'xflamp/cli/version'
    autoload :Watch,   'xflamp/cli/watch'

    extend self

    def run(*args)
      args, opts = preparse(args)
      name       = args.shift unless args.empty?
      command    = command(name).new
      command.parse(args)
      command.execute
    end

    def commands
      CLI.constants.map { |n| try_const_get(n) }.select { |c| command? c }
    end

    def command(name)
      const_name = command_name(name)
      constant   = CLI.const_get(const_name) if const_name =~ /^[A-Z][A-Za-z]+$/ and const_defined? const_name
      if command? constant
        constant
      else
        puts "unknown command #{name}"
        exit 1
      end
    end

    private

    def try_const_get(name)
      CLI.const_get(name)
    rescue Exception
    end

    def command?(constant)
      constant.is_a? Class and constant < Command and not constant.abstract?
    end

    def command_name(name)
      case name
      when nil, '-h', '-?' then 'Help'
      when '-v'            then 'Version'
      when /^--/           then command_name(name[2..-1])
      else name.split('-').map(&:capitalize).join
      end
    end

    def preparse(unparsed, args = [], opts = {})
      case unparsed
      when Hash  then opts.merge! unparsed
      when Array then unparsed.each { |e| preparse(e, args, opts) }
      else args << unparsed.to_s
      end
      [args, opts]
    end
  end
end

