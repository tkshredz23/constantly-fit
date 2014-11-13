module Nike
  module Configuration
    DEFAULT_ENDPOINT = "https://developer.nike.com".freeze
    DEFAULT_TIMEOUT = 5000
    DEFAULT_OPEN_TIMEOUT = 5000
    DEFAULT_ADAPTER = Faraday.default_adapter


    VALID_OPTIONS_KEYS = [
      :http_adapter,
      :endpoint,
      :timeout,
      :open_timeout,
    ]

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.open_timeout = DEFAULT_OPEN_TIMEOUT
      self.http_adapter = DEFAULT_ADAPTER
      self
    end

    def configure
      yield self
      self
    end
  end
end


