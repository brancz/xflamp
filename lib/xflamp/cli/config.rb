require 'xflamp/cli/command'
require 'inquirer'
require 'travis/client'

module XFLamp
  class CLI
    class Config < Command
      def run
        travis_token = Ask.input 'Your Travis Access Token'
        client = Travis::Client.new :access_token => travis_token
        repos = client.user.repositories.select(&:active?)
        repo_selection = Ask.checkbox 'Which repos do you want to watch?', repos.map(&:slug)
        repos_to_watch = repos.select.with_index { |_, i| repo_selection[i] }
        build_servers = {
          'travis-ci-org' => { 'projects' => repos_to_watch.map(&:slug) }
        }
        config.servers = BuildServers.new build_servers
        config.save
        puts "Config saved in ./xflamp.yml"
      end
    end
  end
end
