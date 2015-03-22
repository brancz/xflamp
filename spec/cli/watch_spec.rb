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

  it 'is a passing build' do
    TravisStub.single_repo
    gpio_stub = double('gpio')
    allow(gpio_stub).to receive(:mode).with(0, OUTPUT)
    allow(gpio_stub).to receive(:write).with(0, 0)
    allow(WiringPi::GPIO).to receive(:new).and_return(gpio_stub)
    run_cli('watch', '--once')
    expect(last_run.stdout).to eq "All watched builds are passing!\n"
  end

  it 'is a failing build' do
    TravisStub.single_repo(:last_build_state => 'failed')
    gpio_stub = double('gpio')
    allow(gpio_stub).to receive(:mode).with(0, OUTPUT)
    allow(gpio_stub).to receive(:write).with(0, 1)
    allow(WiringPi::GPIO).to receive(:new).and_return(gpio_stub)
    run_cli('watch', '--once')
    expect(last_run.stdout).to eq "There is at least one build that is not passing...\n"
  end
end

