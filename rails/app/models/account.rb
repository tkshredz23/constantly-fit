class Account < ActiveRecord::Base
  # has_one :profile
  has_many :activities
  belongs_to :user

  validates_presence_of   :auth_token, on: :create
  validates_uniqueness_of :uid, scope: :type, on: :create

  def self.auth_mapping(opts)
    {
      provider: opts["provider"],
      uid: opts["uid"].to_s,
      auth_token: opts['credentials']['token'],
      auth_secret: opts['credentials']['secret'],
      type: "#{opts['provider'].capitalize}::Account",
      status: 'A',
    }
  end

  def self.create_from_omniauth(opts, klass = self)

    hash = klass.auth_mapping(opts)

    account = where(hash.slice(:provider, :uid)).first_or_create(hash)

    if account.auth_token != hash['auth_token'] && account.auth_secret != hash['auth_secret']
      account.update_attributes!(hash.slice(:auth_token, :auth_secret))
    end

    if account.valid?
      account.fetch_recent_activities
      account
    else
      nil
    end
  end
end
