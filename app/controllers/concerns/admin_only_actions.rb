module AdminOnlyActions
  extend ActiveSupport::Concern

  # Call this in a before_action callback, but after you've located your exchange.
  def admin_only
    unless logged_in? && current_participant.admin?
      redirect_to exchange_path(@exchange), alert: "You need to be logged in and be the exchange creator to edit. " \
        "Use the login link in your signup email if you are the creator."
    end
  end
end
