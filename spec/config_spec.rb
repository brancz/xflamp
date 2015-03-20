require 'fakefs/spec_helpers'

describe XFLamp::Config do
  include FakeFS::SpecHelpers::All

  before :each do
    TravisStub.heartbeat
    TravisStub.single_repo
  end

  it 'reads the config' do
    expected = {
      'servers' => {
        'travis-ci-org' => { 'projects' => ['flower-pot/xflamp'] }
      }
    }
    File.open('xflamp.yml', 'w') { |f| f.write expected.to_yaml }

    config = XFLamp::Config.new('xflamp.yml')
    config.load
    expect(config.servers.to_h).to eq expected['servers']
  end

  it 'writes the config' do
    config = XFLamp::Config.new('xflamp.yml')
    config.servers = XFLamp::BuildServers.new({
      'travis-ci-org' => {
        'projects' => ['flower-pot/xflamp']
      }
    })
    config.save

    expect(File.read('xflamp.yml')).to eq(
      "---\n" +
      "servers:\n" +
      "  travis-ci-org:\n" +
      "    projects:\n" +
      "    - flower-pot/xflamp\n"
    )
  end
end

