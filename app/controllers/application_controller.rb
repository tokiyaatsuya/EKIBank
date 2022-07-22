class ApplicationController < ActionController::Base
  before_action :basic_auth
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    root_path
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
  Q_18 = 18
  Q_19 = 19

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
