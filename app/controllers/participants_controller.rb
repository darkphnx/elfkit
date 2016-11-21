class ParticipantsController < ApplicationController
  include AdminOnlyActions

  before_action do
    @exchange = Exchange.find_by_permalink(params[:exchange_id])
    @participant = @exchange.participants.find_by_permalink(params[:id])
  end

  before_action except: :create do
    unless @participant == current_participant || current_participant.admin?
      redirect_to exchange_path(@exchange_path), "You need to be logged in to do that"
    end
  end

  before_action do
    unless @exchange.signup_stage?
      redirect_to exchange_path(@exchange), alert: "Sorry, participants can't be altered once matching has taken place"
    end
  end

  before_action :admin_only, only: [:destroy]

  def create
    @participant = @exchange.participants.build(safe_create_participant_params)

    respond_to do |wants|
      if @participant.save
        redirect_url = exchange_path(@exchange, invited: @participant.permalink)

        wants.html { redirect_to redirect_url }
        wants.json { render json: { redirect: redirect_url } }
      else
        wants.html do
          redirect_to exchange_path(@exchange), alert: "Sorry, couldn't send invite. Please check your name or " \
            "e-mail address."
        end
        wants.json { render json: js_errors_for(@participant), status: :unprocessable_entity }
      end
    end
  end

  def update
    if @participant.update(safe_update_participant_params)
      redirect_to exchange_path(@exchange)
    else
      redirect_to exchange_path(@exchange), alert: "Sorry, couldn't update your preferences at this time"
    end
  end

  def destroy
    if @participant.destroy
      redirect_to edit_exchange_path(@exchange), notice: "Removed #{@participant.name} successfully"
    else
      redirect_to edit_exchange_path(@exchange), alert: "Sorry, couldn't remove #{@participant}"
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
