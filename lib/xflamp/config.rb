require 'yaml'

module XFLamp
  module Config
    class ConfigMissing < StandardError; end

    module_function

    def servers
      YAML.load_file(config_path)['servers']
    rescue
      raise ConfigMissing
    end

    def config_path=(path)
      @path = path
    end

    def config_path
      @path ||= 'xflamp.yml'
    end

    def pin=(pin)
      @pin = pin
    end

    def pin
      @pin ||= 0
    end
  end
end

