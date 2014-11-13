module Nike
  class Client < BaseModel
    class << self
      def get_token(username, password)
        params = set_params(username, password, 'services/login')
        post("", params)['access_token']
      end

      private
      def set_params(username, password, endpoint)
        {
          username: username,
          password: password,
          endpoint: endpoint
        }
      end
    end
  end
end
