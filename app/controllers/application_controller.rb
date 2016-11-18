class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_participant
    @current_participant ||= begin
      if @exchange && session[:participants]
        participant = Participant.find_by_login_token!(session[:participants][@exchange.permalink])
        participant.activity!
        participant
      end
    end
  end

  def current_participant=(participant)
    if @exchange
      session[:participants] ||= {}
      session[:participants][@exchange.permalink] = participant.login_token
    end
  end

  def logged_in?
    current_participant.is_a?(Participant)
  end

  helper_method :logged_in?, :current_participant
end
