require 'xflamp/cli/command'
require 'xflamp/travis'
require 'json'

module XFLamp
  module CLI
    class Config < Command
      description 'configure the builds to watch'

      on('-t', '--token [TOKEN]', 'access token to retrieve projects from travis')

      def run
        self.token ||= ask_for_travis_token
        repos = potential_repos(self.token)
        repos_to_watch = ask_for_selecting_repos repos
        build_servers = {
          'travis-ci-org' => { 'projects' => repos_to_watch }
        }
        config.servers = BuildServers.new build_servers
        config.save
        puts "Config saved in ./xflamp.yml"
      rescue => e
        puts e.message
      end

      def ask_for_travis_token
        `whiptail --inputbox "Please provide your travis auth token: " 8 78  3>&1 1>&2 2>&3`
      end

      def ask_for_selecting_repos(repos)
        repos = repos.map{|r|"\"#{r}\" \"#{r}\" off"}.join ' '
        `whiptail --separate-output --checklist "Please select the repos you want to watch " 15 80 10 #{repos} 3>&1 1>&2 2>&3`.split
      end

      def potential_repos(access_token)
        uri = TravisCI::Org.base_api_uri
        http = TravisCI::Org.http_client(access_token)
        uri.path = '/repos'
        uri.query = "member=#{user(access_token)}"
        res = http.get(uri)
        JSON.parse(res.body)['repos'].map { |r| r['slug'] }
      end

      def user(access_token)
        uri = TravisCI::Org.base_api_uri
        http = TravisCI::Org.http_client(access_token)
        uri.path = '/users'
        res = http.get(uri)
        fail StandardError, res.body unless res.is_a? Net::HTTPOK
        JSON.parse(res.body)['user']['login']
      end
    end
  end
end
