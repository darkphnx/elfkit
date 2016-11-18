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

  scope :require_matching, -> { where('match_at <= ? AND stage = ?', Time.now.utc, 'signup') }
  scope :require_completing, -> { where('exchange_at <= ? AND stage = ?', Time.now.utc, 'matched') }
  scope :require_match_reminder_sending, lambda {
    where('match_at <= ? AND match_reminder_sent_at IS NULL', Time.now.utc + 7.days)
  }
  scope :require_exchange_reminder_sending, lambda {
    where('exchange_at <= ? AND exchange_reminder_sent_at IS NULL', Time.now.utc + 7.days)
  }

  def pair_participants
    matchmaker.pair.each do |gifter, giftee|
      participant_matches.build(gifter: gifter, giftee: giftee)
    end
  end

  def match!
    pair_participants
    self.stage = 'matched'
    save!
  end

  def complete!
    self.stage = 'completed'
    save!
  end

  STAGES.each do |status_name|
    define_method "#{status_name}_stage?".to_sym do
      stage == status_name
    end
  end

  def send_match_reminder_emails
    send_participants_email(:match_reminder)
  end

  def send_match_ready_emails
    send_participants_email(:match_ready)
  end

  def send_exchange_reminder_emails
    send_participants_email(:exchange_reminder)
  end

  private

  def send_participants_email(email_name)
    email_name = "send_#{email_name}_email".to_sym
    participants.participating.each(&email_name)
  end

  def set_initial_stage
    self.stage ||= 'signup'
  end

  def matchmaker
    @matchmaker ||= Elfkit::Matchmaker.new(participants.participating)
  end
end
