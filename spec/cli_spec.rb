require 'fakefs/spec_helpers'
require 'xflamp/cli'
require 'support/helpers'

describe XFLamp::CLI do
  include FakeFS::SpecHelpers::All
  include Helpers

  before :each do
    File.open('xflamp.yml', 'w') do |f|
      f.write({
        'servers' => {
          'travis-ci-org' => { 'projects' => ['flower-pot/xflamp'] }
        }
      }.to_yaml)
    end
  end

  it 'tells you when the requested command does not exist' do
    run_cli('somecommand')
    expect(last_run.success?).to be false
  end
end

