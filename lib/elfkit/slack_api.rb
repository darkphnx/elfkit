module Elfkit
  class SlackAPI
    def initialize(auth_token)
      @auth_token = auth_token
    end

    def post_message
    end

    private

    def connection
      @connection ||= Faraday.new("https://slack.com/api") do |builder|
        builder.request :oauth2, @auth_token, token_type: 'bearer'
        builder.request :json

        builder.response :json

        builder.adapter Faraday.default_adapter
      end
    end
  end
end
