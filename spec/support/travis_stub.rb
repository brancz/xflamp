module TravisStub

  module_function

  def heartbeat
    WebMock::API.stub_request(:head, "https://api.travis-ci.org/").
      with(:headers => {'Accept'=>'application/vnd.travis-ci.2+json'}).
      to_return(:status => 200, :body => '', :headers => {})
  end

  def single_repo
    WebMock::API.stub_request(:get, "https://api.travis-ci.org/repos/flower-pot/xflamp").
      with(:headers => {'Accept'=>'application/vnd.travis-ci.2+json'}).
      to_return(:status => 200, :body => '{"repo":{"id":3977596,"slug":"flower-pot/xflamp","description":"tiny ruby program which turns on a lamp through a raspberry pi\'s gpio and a digital relay","last_build_id":55174148,"last_build_number":"3","last_build_state":"passed","last_build_duration":23,"last_build_language":null,"last_build_started_at":"2015-03-20T13:39:02Z","last_build_finished_at":"2015-03-20T13:39:25Z","github_language":"Ruby"}}', :headers => {})
  end

  def single_repo_by_id(options = { :last_build_state => :passed })
    WebMock::API.stub_request(:get, "https://api.travis-ci.org/repos/3977596").
      with(:headers => {'Accept'=>'application/vnd.travis-ci.2+json'}).
      to_return(:status => 200, :body => '{"repo":{"id":3977596,"slug":"flower-pot/xflamp","description":"tiny ruby program which turns on a lamp through a raspberry pi\'s gpio and a digital relay","last_build_id":55174148,"last_build_number":"3","last_build_state":"' + options[:last_build_state].to_s + '","last_build_duration":23,"last_build_language":null,"last_build_started_at":"2015-03-20T13:39:02Z","last_build_finished_at":"2015-03-20T13:39:25Z","github_language":"Ruby"}}', :headers => {})
  end
end
