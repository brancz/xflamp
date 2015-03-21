require 'uri'
require 'json'

require 'xflamp/build_servers'
require 'xflamp/http'

module XFLamp
  module TravisCI
    Project = Struct.new(:repo_slug)

    class Org
      attr_reader :projects

      def initialize(config)
        @projects = config['projects'].map do |repo_slug|
          Project.new repo_slug
        end
      end

      def green?
        @projects.each do |project|
          return false unless project_green?(project)
        end
        true
      end

      def project_green?(project)
        uri = self.class.base_api_uri
        uri.path = "/repos/#{project.repo_slug}"
        res = self.class.http_client.get uri
        last_build_status = JSON.parse(res.body)['repo']['last_build_state']
        'passed' == last_build_status
      end

      def to_h
        { 'projects' => @projects.map(&:repo_slug) }
      end

      def self.name
        'travis-ci-org'
      end

      def self.http_client(access_token = nil)
        default_headers = { 'Accept' => 'application/vnd.travis-ci.2+json' }
        default_headers['Authorization'] = "token \"#{access_token}\"" if access_token
        HTTP.new(default_headers)
      end

      def self.base_api_uri
        URI("https://api.travis-ci.org/")
      end
    end
  end
end

XFLamp::BuildServers.register_build_server_type(XFLamp::TravisCI::Org)

