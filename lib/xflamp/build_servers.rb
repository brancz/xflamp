require 'xflamp/aggregated_green'
require 'xflamp/config'
require 'xflamp/travis'

module XFLamp
  class BuildServers
    include AggregatedGreen

    attr_reader :build_servers
    alias_method :targets, :build_servers

    def initialize(build_server_config = Config.servers)
      @build_servers = []
      build_server_config.each do |server, config|
        @build_servers << TravisCI::Org.new(config) if server == 'travis-ci-org'
      end
    end
  end
end

