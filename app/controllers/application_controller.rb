class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :mark_session

  def mark_session
    session[:api_message] = "API received: #{Time.zone.now}"
    ap session
  end

  def current_user
    u = OpenStruct.new(session[:current_user])
    ap u
    u
  end
  helper_method :current_user

  def user_signed_in?
    !!session[:current_user]
  end
  helper_method :user_signed_in?

  def ensure_logged_in
    redirect_to_login unless user_signed_in?
  end

  def redirect_to_login
    redirect_to login_path
  end

  def logout_path
    "#{identity_service_url}/auth/logout"
  end
  helper_method :logout_path

  def login_path
    "#{identity_service_url}"
  end
  helper_method :login_path

  def identity_service_url
    ENV['IDENTITY_API_URL']
  end
end
