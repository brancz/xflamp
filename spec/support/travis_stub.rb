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
      to_return(:status => 200, :body => '{"repo":{"id":3977596,"slug":"flower-pot/xflamp","description":"tiny ruby program which turns on a lamp through a raspberry pi\'s gpio and a digital relay","last_build_id":null,"last_build_number":null,"last_build_state":"","last_build_duration":null,"last_build_language":null,"last_build_started_at":null,"last_build_finished_at":null,"github_language":"Ruby"}}', :headers => {})
  end

  def single_repo_by_id
    WebMock::API.stub_request(:get, "https://api.travis-ci.org/repos/3977596").
      with(:headers => {'Accept'=>'application/vnd.travis-ci.2+json'}).
      to_return(:status => 200, :body => '{"repo":{"id":3977596,"slug":"flower-pot/xflamp","description":"tiny ruby program which turns on a lamp through a raspberry pi\'s gpio and a digital relay","last_build_id":null,"last_build_number":null,"last_build_state":"","last_build_duration":null,"last_build_language":null,"last_build_started_at":null,"last_build_finished_at":null,"github_language":"Ruby"}}', :headers => {})
  end
end
