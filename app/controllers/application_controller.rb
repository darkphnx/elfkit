class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= Participant.find_by_login_token(session[:participant])
  end

  def current_user=(participant)
    session[:participant] = participant.login_token
    participant
  end

  def logged_in?
    current_user.is_a?(Participant)
  end

  helper_method :logged_in?, :current_user
end
