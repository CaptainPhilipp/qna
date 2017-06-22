# find or create Oauth authorization && user
class OauthUserAuthorization
  def initialize(oauth_hash)
    @oauth_hash = oauth_hash
  end

  def call
    user = User.find_for_oauth(oauth_hash)
    return user if user

    find_or_create_user
  end

  private

  attr_reader :oauth_hash

  def find_or_create_user
    user = User.find_by_any(oauth_hash) ||
           User.create_for_oauth(oauth_hash)

    user.oauth_authorizations << authorization_object
    user
  end

  def authorization_object
    @authorization ||= OauthAuthorization.find_or_create(oauth_hash)
  end
end