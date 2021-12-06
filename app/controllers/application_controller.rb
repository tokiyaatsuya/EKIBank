class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    pages_show_path
  end

#質問IDを定数化
  Q_01 = 1
  Q_02 = 2
  Q_03 = 3
  Q_05 = 5
  Q_07 = 7
  Q_08 = 8
  Q_09 = 9
  Q_10 = 10
  Q_11 = 11
  Q_12 = 12
  Q_13 = 13
  Q_14 = 14
  Q_15 = 15
  Q_16 = 16
  Q_17 = 17

  private
          
  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
