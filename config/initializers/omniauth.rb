require 'omniauth-slack'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, Rails.application.secrets[:slack_client_id], Rails.application.secrets[:slack_client_secret], scope: 'bot'
end
