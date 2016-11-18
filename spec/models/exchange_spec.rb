require 'rails_helper'
require 'models/shared_examples_for_permalinks'

RSpec.describe Exchange, type: :model do
  describe "validations" do
    it_should_behave_like "it has a permalink"

    it { is_expected.to validate_presence_of(:title) }
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

  describe '.require_matching' do
    before(:each) do
      # Records need to be created in the past, or the validation fails
      travel_to(2.hours.ago)
      @unprocessed = [create(:exchange, match_at: 1.minute.from_now, stage: 'signup'),
                      create(:exchange, match_at: 2.hours.from_now, stage: 'signup')]
      @processed = [create(:exchange, match_at: 1.minute.from_now, stage: 'matched')]
      travel_back
      @future = [create(:exchange)]
    end

    it "returns exchanges that need matching, bit haven't been processed yet" do
      expect(described_class.require_matching).to include(*@unprocessed)
    end

    it 'does not return exchanges that have been previously processed' do
      expect(described_class.require_matching).to_not include(*@processed)
    end

    it 'does not return exchanges that are in the future' do
      expect(described_class.require_matching).to_not include(*@future)
    end
  end

  describe '.require_completing' do
    before(:each) do
      # Records need to be created in the past, or the validation fails
      travel_to(2.hours.ago)
      @unprocessed = [create(:exchange, exchange_at: 1.minute.from_now, stage: 'matched'),
                      create(:exchange, exchange_at: 2.hours.from_now, stage: 'matched')]
      @processed = [create(:exchange, exchange_at: 1.minute.from_now, stage: 'completed')]
      travel_back
      @future = [create(:exchange, exchange_at: 1.hour.from_now, stage: 'matched')]
    end

    it "returns exchanges that need completing, bit haven't been processed yet" do
      expect(described_class.require_completing).to include(*@unprocessed)
    end

    it 'does not return exchanges that have been previously processed' do
      expect(described_class.require_completing).to_not include(*@processed)
    end

    it 'does not return exchanges that are in the future' do
      expect(described_class.require_completing).to_not include(*@future)
    end
  end

  describe '.require_match_reminder_sending' do
    before(:each) do
      @to_remind = [create(:exchange, match_at: 1.week.from_now), create(:exchange, match_at: 6.days.from_now)]
      @reminded = [create(:exchange, match_at: 1.week.from_now, match_reminder_sent_at: Time.now.utc)]
      @future = [create(:exchange, match_at: 2.weeks.from_now)]
    end

    it 'matches exchanges that are matching less than 1 week from now' do
      expect(described_class.require_match_reminder_sending).to include(*@to_remind)
    end

    it 'does not match exchanges that have had their reminders sent' do
      expect(described_class.require_match_reminder_sending).to_not include(*@reminded)
    end

    it 'does not match exchanges that are matching more than a week away' do
      expect(described_class.require_match_reminder_sending).to_not include(*@future)
    end
  end

  describe '.require_exchange_reminder_sending' do
    before(:each) do
      @to_remind = [create(:exchange, exchange_at: 1.week.from_now), create(:exchange, exchange_at: 6.days.from_now)]
      @reminded = [create(:exchange, exchange_at: 1.week.from_now, exchange_reminder_sent_at: Time.now.utc)]
      @future = [create(:exchange, exchange_at: 2.weeks.from_now)]
    end

    it 'matches exchanges that are exchanging less than 1 week from now' do
      expect(described_class.require_exchange_reminder_sending).to include(*@to_remind)
    end

    it 'does not match exchanges that have had their reminders sent' do
      expect(described_class.require_exchange_reminder_sending).to_not include(*@reminded)
    end

    it 'does not match exchanges that are exchanging more than a week away' do
      expect(described_class.require_exchange_reminder_sending).to_not include(*@future)
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
      @exchange = create(:exchange)
      @participants = create_list(:participant, 3, participating: true, exchange: @exchange)
      @non_participant = create(:participant, participating: false, exchange: @exchange)
      @exchange.pair_participants
    end

    it 'creates a participant_match for each participant' do
      expect(@participants.length).to eq(3)
    end

    it 'makes each participant a gifter' do
      gifters = @exchange.participant_matches.map(&:gifter)
      expect(gifters).to include(*@participants)
    end

    it 'makes each participant a giftee' do
      giftees = @exchange.participant_matches.map(&:giftee)
      expect(giftees).to include(*@participants)
    end

    it 'does not include users who are not participating' do
      giftees = @exchange.participant_matches.map(&:giftee)
      gifters = @exchange.participant_matches.map(&:gifter)

      expect(giftees).to_not include(@non_participant)
      expect(gifters).to_not include(@non_participant)
    end
  end

  describe 'match!' do
    before(:each) do
      @exchange = create(:exchange, stage: 'signup')
    end

    it 'pairs the participants' do
      expect(@exchange).to receive(:pair_participants)
      @exchange.match!
    end

    it 'marks the stage as matched' do
      @exchange.match!
      expect(@exchange.stage).to eq('matched')
    end

    it 'saves the record' do
      expect(@exchange).to receive(:save!)
      @exchange.match!
    end
  end

  describe 'complete!' do
    before(:each) do
      @exchange = create(:exchange, stage: 'matched')
    end

    it 'marks the stage as matched' do
      @exchange.complete!
      expect(@exchange.stage).to eq('completed')
    end

    it 'saves the record' do
      expect(@exchange).to receive(:save!)
      @exchange.complete!
    end
  end
end
