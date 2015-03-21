require 'net/http'

module XFLamp
  class HTTP
    attr_reader :default_headers

    def initialize(default_headers = {})
      @default_headers = default_headers
    end

    def get(uri, headers = {})
      req = Net::HTTP::Get.new(
        "#{uri.path}?#{uri.query}", 
        initheader = default_headers.merge(headers)
      )
      http_client(uri).request(req)
    end

    private

    def http_client(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      http
    end
  end
end

