require 'wiringpi'

module XFLamp
  class Lamp
    def initialize(pin = 0)
      @pin = pin
      @gpio = WiringPi::GPIO.new
      @gpio.mode pin, OUTPUT
    end

    def on!
      @gpio.write pin, 0
    end

    def off!
      @gpio.write pin, 0
    end
  end
end

