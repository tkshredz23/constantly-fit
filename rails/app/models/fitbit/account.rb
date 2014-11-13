class Fitbit::Account < Account
  include Fitbit::Activity

  def data
    raise "Account is not linked with a Fitbit account" unless linked?
    @client ||= Fitgem::Client.new(
      consumer_key: ENV["FITBIT_KEY"],
      consumer_secret: ENV["FITBIT_SECRET"],
      token: auth_token,
      secret: auth_secret,
      user_id: uid
    )
  end

  def self.auth_mapping(auth)
    super(auth)
  end

  def linked?
    auth_token.present? && auth_secret.present?
  end

  private

  def full_location(opts)
    missing = ['city', 'state', 'country'] - opts.keys

    unless missing.size > 0
      "#{opts['city']}, #{opts['state']} #{opts['country']}"
    else
      opts['country']
    end
  end
end
