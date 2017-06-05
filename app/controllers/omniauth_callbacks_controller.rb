class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authenticate_user('facebook')
  end

  def twitter
    authenticate_user('twitter')
  end

  def new_email
    if params[:email].present?
      session[:oauth].info.email = parmas[:email]
      auth(session[:oauth])
    else
      set_flash_message(:error, :empty_email) if is_navigational_format?
      render template: 'users/email'
    end
  end

  private

  def authenticate_user(provider)
    session[:oauth] = request.env['omniauth.auth']
    auth(session[:oauth])
  end

  def auth(oauth)
    byebug
    if oauth.info.email.present? || User.find_by_uid(oauth)
      @user = User.find_for_oauth(oauth)
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: oauth.provider) if is_navigational_format?
      end
    else
      render 'users/email'
    end
  end
end
