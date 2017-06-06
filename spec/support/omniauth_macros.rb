module OmniauthMacros
  def mock_auth_hash_twitter
    OmniAuth.config.mock_auth[:twitter] = {
      provider:  'twitter',
      uid: '123545',
      info: {
        email: 'test@test.com',
        name: 'User'
      }
  end

  def mock_auth_hash_facebook
    OmniAuth.config.mock_auth[:facebook] = {
      provider:  'facebook',
      uid: '123545',
      info: {
        email: 'test@test.com',
        name: 'User'
      }
  end

  def mock_auth_hash_without_email
    OmniAuth.config.mock_auth[:twitter] = {
      provider:  'twitter',
      uid: '123545',
      info: {
        email: '',
        name: 'User'
      }
  end
end
