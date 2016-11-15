class ParticipantsController < ApplicationController
  before_action do
    @exchange = Exchange.find_by_permalink(params[:exchange_id])
  end

  def create
    @participant = @exchange.participants.build(safe_participant_params)

    if @participant.save
      redirect_to exchange_path(@exchange), notice: "Invite sent, please check your e-mail"
    else
      redirect_to exchange_path(@exchange), alert: "Sorry, couldn't send invite"
    end
  end

  private

  def safe_participant_params
    params.require(:participant).permit(:name, :email_address)
  end
end
