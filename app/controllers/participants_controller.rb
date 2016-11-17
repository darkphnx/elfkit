class ParticipantsController < ApplicationController
  before_action do
    @exchange = Exchange.find_by_permalink(params[:exchange_id])
    @participant = @exchange.participants.find_by_permalink(params[:id])
  end

  before_action except: :create do
    if @participant != current_participant
      redirect_to exchange_path(@exchange_path), "You need to be logged in to do that"
    end
  end

  def create
    @participant = @exchange.participants.build(safe_create_participant_params)

    if @participant.save
      @participant.send_confirmation_email
      redirect_to exchange_path(@exchange), notice: "Invite sent, please check your e-mail"
    else
      redirect_to exchange_path(@exchange), alert: "Sorry, couldn't send invite"
    end
  end

  def update
    if @participant.update(safe_update_participant_params)
      redirect_to exchange_path(@exchange)
    else
      redirect_to exchange_path(@exchange), alert: "Sorry, couldn't update your preferences at this time"
    end
  end

  private

  def safe_create_participant_params
    params.require(:participant).permit(:name, :email_address)
  end

  def safe_update_participant_params
    params.require(:participant).permit(:participating)
  end
end
