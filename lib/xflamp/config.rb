require 'yaml'

module XFLamp
  module Config
    class ConfigMissing < StandardError; end

    module_function

    def servers
      YAML.load_file('xflamp.yml')['servers']
    rescue
      raise ConfigMissing
    end
  end
end

