class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authenticate_user('facebook')
  end

  def twitter
    authenticate_user('twitter')
  end

  def new_email
    if params[:email].present?
      oauth = kyes_to_sym(session[:oauth])
      oauth[:info][:email] = params[:email]
      oauth[:info][:need_to_confirm] = true
      auth(oauth)
    else
      set_flash_message(:error, :empty_email) if is_navigational_format?
      render template: 'users/email'
    end
  end

  private

  def authenticate_user(provider)
    session[:oauth] = request.env['omniauth.auth']
    byebug
    auth(session[:oauth])
  end

  def auth(oauth)
    if oauth[:info][:email].present?
      @user = User.find_for_oauth(oauth)
      if @user && @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: oauth[:provider]) if is_navigational_format?
      else
        set_flash_message(:notice, :failure, kind: oauth[:provider], reason: 'you need to confirm email') if is_navigational_format?
        redirect_to root_path
      end
    else
      render 'users/email'
    end
  end

  def kyes_to_sym(hash)
    oauth = {}
    hash.each do |key, value|
      oauth[key.to_sym] = value.is_a?(Hash) ? value.symbolize_keys! : value
    end
    oauth
  end
end
