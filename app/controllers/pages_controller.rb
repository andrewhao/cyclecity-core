class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :protect_from_forgery

  def root
    ap session
    session[:api_message] = "API received: #{Time.zone.now}"
  end
end
