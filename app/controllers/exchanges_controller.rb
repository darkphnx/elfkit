class ExchangesController < ApplicationController
  before_action do
    @exchange = Exchange.find_by_permalink!(params[:id]) if params[:id]
  end

  before_action only: [:edit, :update, :destroy] do
    unless logged_in? && current_participant.admin?
      redirect_to exchange_path(@exchange), alert: "You need to be logged in and be the exchange creator to edit. " \
        "Use the login link in your signup email if you are the creator."
    end
  end

  around_action :use_exchange_timestamp

  def new
    @exchange = Exchange.new(match_at: 2.weeks.from_now, exchange_at: 4.weeks.from_now)
    @first_participant = Participant.new
  end

  def create
    @first_participant = Participant.new(safe_participant_params)
    @first_participant.admin = true

    @exchange = Exchange.new(safe_exchange_params)
    @exchange.participants << @first_participant

    if @exchange.save
      redirect_to exchange_path(@exchange, invited: @first_participant.permalink)
    else
      render :new
    end
  end

  def show
    @participants = @exchange.participants.participating

    if params[:invited]
      @participant = @exchange.participants.find_by_permalink(params[:invited])
    else
      @participant = @exchange.participants.build
    end
  end

  def edit
  end

  def update
    if @exchange.update_attributes(safe_exchange_params)
      redirect_to exchange_path(@exchange)
    else
      render :edit
    end
  end

  def destroy
    if @exchange.destroy
      redirect_to root_path, notice: "Your exchange has been cancelled and your participants notified."
    else
      redirect_to exchange_path(@exchange), alert: "Sorry, we couldn't delete your exchange. " \
        "Please try again later."
    end
  end

  private

  def use_exchange_timestamp
    Time.zone = request_time_zone
    yield
  ensure
    Time.zone = nil
  end

  def request_time_zone
    if params[:exchange] && params[:exchange][:time_zone]
      params[:exchange][:time_zone]
    elsif @exchange
      @exchange.time_zone
    end
  end

  def safe_exchange_params
    params.require(:exchange).permit(:title, :match_at, :exchange_at, :time_zone)
  end

  def safe_participant_params
    params[:exchange].require(:participant).permit(:name, :email_address)
  end
end
