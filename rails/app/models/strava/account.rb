class Strava::Account < Account
  include Strava::Activity

  def data
    raise "Account is not linked with a #{user.type} account" unless linked?
    @client ||= Strava::Api::V3::Client.new(access_token: auth_token)
  end

  def self.auth_mapping(auth)
    super(auth)
  end

  def linked?
    auth_token.present?
  end
end
