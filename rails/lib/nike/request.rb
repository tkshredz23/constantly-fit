module Nike
  module Request
    include Connection

    def get(path, params={})
      request(:get, path, params)
    end

    def delete(path, params={})
      request(:delete, path, params)
    end

    def post(path, params={})
      request(:post, path, params)
    end

    def put(path, params={})
      request(:put, path, params)
    end

    private

    def request(method, path, params)
      params ||= {}

      endpoint = params.delete(:endpoint)

      connection.send(method, endpoint, params) do |req|
        req.options.timeout = Nike.timeout
        req.options.open_timeout = Nike.open_timeout
      end.body
    end
  end
end
