class SessionsController < ApplicationController
  before_action do
    @exchange = Exchange.find_by_permalink(params[:exchange_id])
  end

  def create
    @participant = Participant.login(params[:participant_id], params[:login_token])
    if @participant
      self.current_participant = @participant
      redirect_to exchange_path(@exchange)
    else
      redirect_to root_path, alert: "Couldn't login with those credentials"
    end
  end

  def destroy
    reset_session
    redirect_to exchanges_path, notice: "Logged out successfully"
  end
end
