class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :password, :password_confirmation, :current_password) } # forbid email changes
  end

  def authenticate_admin!
    redirect_to(root_path, alert: 'Доступ запрещен') unless current_user && current_user.admin?
    false
  end
  def authenticate!
    redirect_to(new_user_session_path, alert: 'Войдите в систему') unless signed_in?
    false
  end

  def signed_in_as_admin?
    current_user && current_user.admin?
  end
end
