module XFLamp
  class BuildServers
    def initialize(build_server_config)
      @build_servers = {}
      build_server_config.each do |server, config|
        @build_servers[server] = build_server_type(server).new(config)
      end
    end

    def to_h
      result = {}
      @build_servers.each do |server_name, server|
        result[server_name] = server.to_h
      end
      result
    end

    def green?
      @build_servers.values.each do |build_server|
        return false unless build_server.green?
      end
      true
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

