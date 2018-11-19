class SlackbotController < ActionController::Base
  def event
    case params[:type]
    when "url_verification"
      url_verification
    when "event_callback"
      event_callback
    else
      render json: { error: "Unhandled Event Type" }, status: :not_found
    end
  end

  private

  # Return the URL verification challenge
  def url_verification
    render json: { challenge: params[:challenge] }
  end

  # Proccess a calback from the Slack Event API
  def event_callback
    case params[:event][:type]
    when "message"
      parse_message
    when "app_mention"
    end
  end

  def parse_message
    if params[:event][:text].contain?('start an exchange')
    end
  end
end
