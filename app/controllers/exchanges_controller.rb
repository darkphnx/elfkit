class ExchangesController < ApplicationController
  before_action do
    @exchange = Exchange.find_by_permalink(params[:id])
  end

  def new
    @exchange = Exchange.new
    @first_participant = Participant.new
  end

  def create
    @first_participant = Participant.new(safe_participant_params)
    @first_participant.admin = true

    @exchange = Exchange.new(safe_exchange_params)
    @exchange.participants << @first_participant
    
    if @exchange.save
      redirect_to exchange_path(@exchange)
    else
      render :new
    end
  end

  def show
  end

  private

  def safe_exchange_params
    params.require(:exchange).permit(:title, :match_at, :exchange_at)
  end

  def safe_participant_params
    params[:exchange].require(:participant).permit(:name, :email_address)
  end
end
