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

    email = auth[:info][:email]
    user = User.where(email: email).first
    if user && user.confirmed?
      user.authorizations.create(provider: auth[:provider], uid: auth[:uid].to_s)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.send_confirmation_instructions
      # user.authorizations.create(provider: auth[:provider], uid: auth[:uid].to_s)
    end
    user
  end

  def self.find_by_uid(auth)
    Authorization.where(provider: auth[:provider], uid: auth[:uid].to_s).first
  end

  protected

  def confirmation_required?
    false
  end
end
