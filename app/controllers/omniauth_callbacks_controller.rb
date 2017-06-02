class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # @user = User.find_for_oauth(request.env['omniauth.auth'])
    # if @user.persisted?
    #   sign_in_and_redirect @user, event: :authentication
    #   set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    # end
    authenticate_user('facebook')
  end

  def twitter
    # render json: request.env['omniauth.auth']
    authenticate_user('twitter')
    # @user = User.find_for_oauth(request.env['omniauth.auth'])
    # if @user.persisted?
    #   sign_in_and_redirect @user, event: :authentication
    #   set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    # end
  end

  private

  def authenticate_user(provider)
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    end
  end
end
