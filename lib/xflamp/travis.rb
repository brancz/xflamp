require 'travis'
require 'xflamp/aggregated_green'

module XFLamp
  module TravisCI
    class Project
      attr_reader :repo

      def initialize(repo_slug)
        @repo = Travis::Repository.find repo_slug
      end

      def green?
        @repo.last_build.green?
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

