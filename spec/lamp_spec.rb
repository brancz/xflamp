describe '#on!' do
  it 'writes high signal to the gpio' do
    gpio = double 'gpio'
    allow(gpio).to receive(:mode).with(5, OUTPUT)
    allow(gpio).to receive(:write).with(5, 1)
    lamp = XFLamp::Lamp.new 5, gpio

    lamp.on!
  end
end

describe '#off!' do
  it 'writes low signal to the gpio' do
    gpio = double 'gpio'
    allow(gpio).to receive(:mode).with(5, OUTPUT)
    allow(gpio).to receive(:write).with(5, 0)
    lamp = XFLamp::Lamp.new 5, gpio

    lamp.off!
  end
end

