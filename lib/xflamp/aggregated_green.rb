module XFLamp
  module AggregatedGreen
    def green?
      !targets.map(&:green?).include?(false)
    end
  end
end

