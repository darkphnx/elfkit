require 'rails_helper'
require 'models/shared_examples_for_permalinks'

RSpec.describe Exchange, type: :model do
  describe "validations" do
    it_should_behave_like "it has a permalink"

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:match_at) }
    it { is_expected.to validate_presence_of(:exchange_at) }
    it { is_expected.to validate_inclusion_of(:stage).in_array(described_class::STAGES) }

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

  described_class::STAGES.each do |stage_name|
    method_name = "#{stage_name}_stage?"

    describe method_name do
      it 'is true when the correct stage is set' do
        exchange = build(:exchange, stage: stage_name)
        expect(exchange.send(method_name)).to be true
      end

      it 'is false when the wrong stage is set' do
        exchange = build(:exchange, stage: "wrong")
        expect(exchange.send(method_name)).to be false
      end
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

    it 'marks the stage as matched' do
      expect(@exchange.stage).to eq('matched')
    end
  end
end
