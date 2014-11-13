module Nike
  module Connection
    def connection
      @connection ||= begin
        Faraday.new(Nike.endpoint) do |b|
          b.use FaradayMiddleware::FollowRedirects
          b.request :url_encoded
          b.response :logger
          b.response :json

          b.adapter Nike.http_adapter
        end
      end
    end
  end
end
