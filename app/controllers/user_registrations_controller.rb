class UserRegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :email, :phone, :company_name, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :email, :phone, :company_name, :password, :password_confirmation, :current_password)
  end

end
