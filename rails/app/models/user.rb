class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  has_many :accounts
  has_many :activities, through: :accounts

  before_save :ensure_authentication_token
  after_create :build_profile

  def build_profile
    Profile.create(user: self)
  end

  %w(nike strava fitbit runkeeper jawbone).each do |provider|
    self.send(:define_method, "has_#{provider}?") do
      provider_class = "#{provider.capitalize}::Account"
      accounts.map(&:type).include?(provider_class)
    end
  end


  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
