require 'yaml'

module XFLamp
  class Config
    class ConfigMissing < StandardError; end

    attr_reader :config_path
    attr_accessor :servers

    def initialize(config_path)
      @config_path = config_path
    end

    def load
      config = YAML.load_file(config_path)
      self.servers = BuildServers.new config['servers']
    end

    def save
      File.open(config_path, 'w') do |f|
        f.write({ 'servers' => servers.to_h }.to_yaml)
      end
    end
  end
end

