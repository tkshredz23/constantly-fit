class Jawbone::Account < Account
  include Jawbone::Activity

  def data
    raise "Account is not linked with a Fitbit account" unless linked?
    @client = Jawbone::Client.new auth_token
  end

  def reset_token!
    update_attributes!(auth_token: Jawbone::Client.refresh_token(ENV['JAWBONE_SECRET']))
  end

  def self.auth_mapping(auth)
    super(auth)
  end

  def linked?
    auth_token.present?
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
