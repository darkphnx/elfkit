require 'rails_helper'
require 'models/shared_examples_for_permalinks'

RSpec.describe Participant, type: :model do
  describe "validations" do
    it_should_behave_like "it has a permalink"
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email_address) }
  end

  describe "#email_tag" do
    it 'returns a header that can be used for sending email' do
      participant = build(:participant, name: "Dave", email_address: "dave@example.com")
      expect(participant.email_tag).to eq("Dave <dave@example.com>")
    end
  end

  describe "#activity!" do
    it "sets a user as participating if it's their first activity" do
      participant = build(:participant)
      participant.activity!

      expect(participant.participating).to eq(true)
    end

    it "leaves a users participation alone if they've logged in previously" do
      participant = build(:participant, last_activity_at: Time.now.utc)
      participant.activity!

      expect(participant.participating).to be_nil
    end

    it "updates the last_activity_at timestamp" do
      participant = build(:participant)
      participant.activity!

      expect(participant.last_activity_at).to be_a(Time)
    end

    it "calls save (without validation) on the participant" do
      participant = build(:participant)
      expect(participant).to receive(:save).with(validate: false)
      participant.activity!
    end
  end
end
