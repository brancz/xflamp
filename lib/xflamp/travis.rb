require 'travis/client/session'
require 'xflamp/aggregated_green'

module XFLamp
  module TravisCI
    class Project
      attr_reader :repo, :session

      def initialize(repo_slug, server)
        @session = server.session
        @repo = session.find_one(Travis::Client::Repository, repo_slug)
      end

      def green?
        session.reload(repo)
        repo.last_build.green?
      end
    end

    class Org
      include AggregatedGreen

      attr_reader :projects, :session
      alias_method :targets, :projects

      def initialize(config)
        @session = Travis::Client::Session.new
        @projects = config['projects'].map {|repo_slug| Project.new repo_slug, self }
      end
    end
  end
end

