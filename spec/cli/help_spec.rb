require 'fakefs/spec_helpers'
require 'xflamp/cli'
require 'support/helpers'

describe XFLamp::CLI::Watch do
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

  it 'has a help command' do
    run_cli('help')
    expect(last_run.success?).to be true
  end

  it 'has a help command for other commands' do
    run_cli('help', 'watch')
    expect(last_run.success?).to be true
  end

  it 'knows its parameters' do
    run_cli('help', 'help')
    expect(last_run.success?).to be true
  end

  it 'knows its number of parameters' do
    run_cli('help', 'help', 'another one')
    expect(last_run.success?).to be false
  end
end

