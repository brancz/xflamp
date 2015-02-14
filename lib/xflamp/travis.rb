require 'travis'
require 'xflamp/aggregated_green'

module XFLamp
  module TravisCI
    class Project
      attr_reader :repo_slug

      def initialize(repo_slug)
        @repo_slug = repo_slug
      end

      def green?
        repo = Travis::Repository.find(repo_slug)
        green = repo.last_build.green?
        repo.caches.each(&:delete)
        green
      end
    end

    class Org
      include AggregatedGreen

      attr_reader :projects
      alias_method :targets, :projects

      def initialize(config)
        @projects = config['projects'].map {|repo_slug| Project.new repo_slug }
      end
    end
  end
end

