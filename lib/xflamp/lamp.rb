require 'wiringpi'

module XFLamp
  class Lamp
    attr_reader :pin, :gpio

    def initialize(pin)
      @pin = pin
      @gpio = WiringPi::GPIO.new
      gpio.mode pin, OUTPUT
    end

    def on!
      gpio.write pin, 1
    end

    def off!
      gpio.write pin, 0
    end
  end
end

