class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    index_path()
  end

protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path()
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstName, :lastName, :profileName, :email, :password,
    :password_confirmation, :remember_me, :avatar, :avatar_cache) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :profileName, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:firstName, :lastName, :profileName, :email, :password,
    :password_confirmation, :current_password, :avatar, :avatar_cache) }
  end
end

def flash_message
  if flash[:notice]
    %{#{flash[:notice]}}
  elsif flash[:warning]
    %{#{flash[:warning]}}
  elsif flash[:note]
    %{#{flash[:note]}}
  elsif flash[:alert]
    %{#{flash[:alert]}}
  elsif flash[:error]
    %{#{flash[:error]}}
  end
end