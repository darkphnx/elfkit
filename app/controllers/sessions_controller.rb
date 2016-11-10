class SessionsController < ApplicationController
  def create
    @participant = Participant.login(params[:participant], params[:login_token])
    if @participant
      self.current_user = @participant
      redirect_to exchange_path(@participant.exchange)
    else
      redirect_to root_path, alert: "Couldn't login with those credentials"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully"
  end
end