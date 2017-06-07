class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authenticate_user('facebook')
  end

  def twitter
    authenticate_user('twitter')
  end

  def new_email
    if params[:email].present?
      session['oauth.email'] = params[:email]
      session['oauth.need_to_confirm'] = true
      auth
    else
      set_flash_message(:error, :empty_email) if is_navigational_format?
      render template: 'users/email'
    end
  end

  private

  def authenticate_user(provider)
    session['oauth.uid'] = request.env['omniauth.auth'][:uid]
    session['oauth.provider'] = request.env['omniauth.auth'][:provider]
    session['oauth.email'] = request.env['omniauth.auth'][:info][:email]
    if session['oauth.email'].blank?
      render 'users/email'
    else
      auth
    end
  end

  def auth
    @user = User.find_for_oauth(session)
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: session['oauth.provider']) if is_navigational_format?
    else
      set_flash_message(:notice, :failure, kind: session['oauth.provider'],
        reason: 'you need to confirm email') if is_navigational_format?
      redirect_to root_path
    end
  end
end
