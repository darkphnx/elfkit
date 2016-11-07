class Exchange < ApplicationRecord
  include RandomPermalink

  has_many :participants
  has_many :participant_matches

  validates :title, presence: true
  validates :permalink, presence: true

  def pair_participants!
    matchmaker.pair.each do |gifter, giftee|
      participant_matches.create!(gifter: gifter, giftee: giftee)
    end
  end

  def matchmaker
    @matchmaker ||= Elfkit::Matchmaker.new(participants)
  end
end
