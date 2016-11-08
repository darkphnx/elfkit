require 'rails_helper'
require 'models/shared_examples_for_permalinks'

RSpec.describe Exchange, type: :model do
  describe "validations" do
    it_should_behave_like "it has a permalink"

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:match_at) }
    it { is_expected.to validate_presence_of(:exchange_at) }

    it "check the match_at date is in the future" do
      exchange = described_class.new(match_at: 1.day.ago)
      exchange.valid?

      expect(exchange.errors[:match_at]).to include("can't be in the past")
    end

    it "check the exchange_at date is in the future" do
      exchange = described_class.new(exchange_at: 1.day.ago)
      exchange.valid?

      expect(exchange.errors[:exchange_at]).to include("can't be in the past")
    end
  end

  describe '#pair_participants' do
    before(:each) do
      @exchange = build(:exchange)
      @exchange.participants = build_list(:participant, 3, exchange: @exchange)
      @exchange.pair_participants
    end

    it 'creates a participant_match for each participant' do
      expect(@exchange.participant_matches.length).to eq(3)
    end

    it 'makes each participant a gifter' do
      gifters = @exchange.participant_matches.map(&:gifter)
      expect(gifters).to include(*@exchange.participants)
    end

    it 'makes each participant a giftee' do
      giftees = @exchange.participant_matches.map(&:giftee)
      expect(giftees).to include(*@exchange.participants)
    end
  end
end
