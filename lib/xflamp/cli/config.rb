require 'xflamp/cli/command'
require 'travis/client'

module XFLamp
  class CLI
    class Config < Command
      def run
        travis_token = ask_for_travis_token
        client = Travis::Client.new :access_token => travis_token
        repos = client.user.repositories.select(&:active?)
        repos_to_watch = ask_for_selecting_repos repos.map(&:slug)
        puts repos_to_watch
        build_servers = {
          'travis-ci-org' => { 'projects' => repos_to_watch }
        }
        config.servers = BuildServers.new build_servers
        config.save
        puts "Config saved in ./xflamp.yml"
      end

      def ask_for_travis_token
        `whiptail --inputbox "Please provide your travis auth token: " 8 78  3>&1 1>&2 2>&3`
      end

      def ask_for_selecting_repos(repos)
        repos = repos.map{|r|"\"#{r}\" \"#{r}\" off"}.join ' '
        `whiptail --separate-output --checklist "Please select the repos you want to watch " 15 80 10 #{repos} 3>&1 1>&2 2>&3`.split
      end
    end
  end
end
