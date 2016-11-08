require 'rails_helper'

RSpec.describe Elfkit::Matchmaker do
  let(:participants) { build_list(:participant, 7) }
  let(:matchmaker) { described_class.new(participants) }

  describe '.new' do
    it 'accepts an array of participants to be matched' do
      expect(matchmaker.participants).to eq(participants)
    end
  end

  describe '#pair' do
    let(:matches) { matchmaker.pair }

    it 'Generates a tuple for each participant' do
      expect(matches.length).to eq(participants.length)

      matches.each do |match|
        expect(match).to match_array([Participant, Participant])
      end
    end

    it 'Never matches a participant to themselves' do
      matches.each do |gifter, giftee|
        expect(gifter).to_not eq(giftee)
      end
    end

    it 'Only matches each participant as gifter once' do
      distinct_gifters = matches.map(&:first).uniq

      expect(distinct_gifters.length).to eq(participants.length)
    end

    it 'Only matches each participant as giftee once' do
      distinct_giftees = matches.map(&:last).uniq

      expect(distinct_giftees.length).to eq(participants.length)
    end

    it 'Generates a different set of matches each call' do
      first_set = matchmaker.pair
      second_set = matchmaker.pair

      expect(first_set).to_not eq(second_set)
    end
  end
end
