class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if User.find_by(:email => request.env["omniauth.auth"][:info][:email])
      @user = User.find_by(:email => request.env["omniauth.auth"][:info][:email])
      sign_in_and_redirect @user
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
  end
end
