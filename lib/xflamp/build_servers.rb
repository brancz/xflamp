require 'xflamp/aggregated_green'

module XFLamp
  class BuildServers
    include AggregatedGreen

    attr_reader :build_servers
    alias_method :targets, :build_servers

    def initialize(build_server_config)
      @build_servers = []
      build_server_config.each do |server, config|
        @build_servers << build_server_type(server).new(config)
      end
    end

    def build_server_type(type)
      self.class.build_server_types.fetch type
    end

    class << self
      def register_build_server_type(build_server_class)
        build_server_types[build_server_class.name] = build_server_class
      end

      def build_server_types
        @build_servers_types ||= {}
      end
    end
  end
end

