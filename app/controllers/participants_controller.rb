class ParticipantsController < ApplicationController
  before_action do
    @exchange = Exchange.find_by_permalink(params[:exchange_id])
  end

  def create
    safe_participant_params[:participants].each do |participant|
      @exchange.participants.create(participant)
    end

    redirect_to exchange_path(@exchange)
  end

  private

  def safe_participant_params
    params.permit(participants: [:name, :email_address])
  end
end
