require 'yaml'

module XFLamp
  class Config
    class ConfigMissing < StandardError; end

    attr_reader :config

    def initialize(config_path)
      @config = YAML.load_file(config_path)
    rescue
      raise ConfigMissing
    end

    def servers
      config['servers']
    end
  end
end

