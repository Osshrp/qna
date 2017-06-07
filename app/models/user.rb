class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :questions
  has_many :answers
  has_many :votes
  has_many :comments
  has_many :authorizations

  def author_of?(entity)
    entity.user_id == id
  end

  def self.find_for_oauth(auth)
    authorization = find_by_uid(auth)
    return authorization.user if authorization

    email = auth['oauth.email']
    user = User.where(email: email).first
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
    end
    user.authorizations.create(provider: auth['oauth.provider'], uid: auth['oauth.uid'].to_s)
    auth['oauth.need_to_confirm'] ? user.send_confirmation_instructions : user.skip_confirmation!
    user
  end

  def self.find_by_uid(auth)
    Authorization.where(provider: auth['oauth.provider'], uid: auth['oauth.uid'].to_s).first
  end

  protected

  def confirmation_required?
    false
  end
end
