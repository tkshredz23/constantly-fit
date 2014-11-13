class Nike::Account < Account
  include Nike::Activity

  validates_presence_of :uid, :password, on: :create

  before_save :encrypt_password

  attr_accessor :client, :password

  def data
    raise "Account is not linked with a Nike account" unless linked?
    NikeV2::Person.new(access_token: auth_token)
  end

  def reset_token!
    # NOTE: I HATE THIS, but I have no choice since Nike's being a dick!!
    update_attributes!(auth_token: Nike::Client.get_token(uid, Base64.decode64(password_digest)))
  end

  def self.auth_mapping(opts)
    {
      auth_token: opts['auth_token'],
      uid: opts['uid'],
      password: opts['password'],
      provider: opts['provider'],
      type: "#{opts['provider'].capitalize}::Account",
      status: 'A',
    }
  end

  def linked?
    auth_token.present?
  end

  def self.get_token(options)
    Nike::Client.get_token(options[:uid], options[:password])
  end

  private

  def encrypt_password
    if password.present?
      self.password_digest = Base64.encode64(password)
    end
  end
end
