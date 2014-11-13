class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  has_many :accounts
  has_many :activities, through: :accounts

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
end
