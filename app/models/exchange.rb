class Exchange < ApplicationRecord
  include RandomPermalink

  has_many :participants
  has_many :participant_matches

  validates :title, presence: true
  validates :match_at, presence: true, future: true
  validates :exchange_at, presence: true, future: true

  def pair_participants
    matchmaker.pair.each do |gifter, giftee|
      participant_matches.build(gifter: gifter, giftee: giftee)
    end
  end

  private

  def matchmaker
    @matchmaker ||= Elfkit::Matchmaker.new(participants)
  end
end
