class Exchange < ApplicationRecord
  STAGES = %w(signup matched completed).freeze

  include RandomPermalink

  has_many :participants, dependent: :destroy
  has_many :participant_matches, dependent: :destroy

  before_validation :set_initial_stage

  validates :title, presence: true
  validates :match_at, presence: true, future: true, if: :match_at_changed?
  validates :exchange_at, presence: true, future: true, if: :exchange_at_changed?
  validates :stage, inclusion: { in: STAGES }

  def pair_participants
    matchmaker.pair.each do |gifter, giftee|
      participant_matches.build(gifter: gifter, giftee: giftee)
    end

    self.stage = 'matched'
    save
  end

  STAGES.each do |status_name|
    define_method "#{status_name}_stage?".to_sym do
      stage == status_name
    end
  end

  private

  def set_initial_stage
    self.stage ||= 'signup'
  end

  def matchmaker
    @matchmaker ||= Elfkit::Matchmaker.new(participants.participating)
  end
end
