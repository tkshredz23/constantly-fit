class Runkeeper::Account < Account
  include Runkeeper::Activity

  def data
    raise "Account is not linked with a runkeeper account" unless linked?
    @client ||= HealthGraph::User.new(auth_token)
  end

  def self.auth_mapping(auth)
    super(auth)
  end

  def linked?
    auth_token.present?
  end
end
