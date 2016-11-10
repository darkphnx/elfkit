require 'rails_helper'

RSpec.describe ExchangesController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      exchange = create(:exchange)
      get :show, id: exchange.permalink
      expect(response).to have_http_status(:success)
    end
  end

end
