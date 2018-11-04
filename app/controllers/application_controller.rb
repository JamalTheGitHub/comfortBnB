class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :return_url

  def allowed?(action:, user:)
  
  end

  def return_url
    session[:return_to] = request.referer
  end
  
  def back
    session.delete(:return_to)
  end
end
