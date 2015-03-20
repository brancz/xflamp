describe XFLamp::CLI do
  it 'parses the pin flag correctly' do
    cli = XFLamp::CLI.new(['--pin', '5', 'watch'])
    expect(cli.options).to eq ({
      :pin => 5,
      :config_path => 'xflamp.yml',
      :once? => false
    })
  end

  it 'parses the pin flag correctly' do
    cli = XFLamp::CLI.new(['--config', 'other.yml', 'watch'])
    expect(cli.options).to eq ({
      :pin => 0,
      :config_path => 'other.yml',
      :once? => false
    })
  end

  it 'parses the once flag correctly' do
    cli = XFLamp::CLI.new(['--once', 'watch'])
    expect(cli.options).to eq ({
      :pin => 0,
      :config_path => 'xflamp.yml',
      :once? => true
    })
  end

  it 'parses the command correctly without flags set' do
    cli = XFLamp::CLI.new(['watch'])
    expect(cli.command_to_execute).to eq 'watch'
  end

  it 'parses the command correctly with flags set' do
    cli = XFLamp::CLI.new(['--config', 'other.yml', 'watch'])
    expect(cli.command_to_execute).to eq 'watch'
  end
end
