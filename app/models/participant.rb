class Participant < ApplicationRecord
  include RandomPermalink

  belongs_to :exchange
  has_one :participant_match, foreign_key: :gifter_id, dependent: :destroy
  has_one :giftee, through: :participant_match

  validates :name, presence: true
  validates :email_address, presence: true
  validates :login_token, presence: true

  before_validation do
    self.login_token ||= SecureRandom.urlsafe_base64
  end

  scope :participating, -> { where(participating: true) }

  def self.login(permalink, login_token)
    matches = where(permalink: permalink, login_token: login_token)
    matches.first
  end

  def email_tag
    "#{name} <#{email_address}>"
  end

  def send_confirmation_email
    ParticipantMailer.confirm_participation(self).deliver
  end

  def send_match_ready_email
    ParticipantMailer.match_ready(self).deliver
  end

  def send_exchange_reminder_email
    ParticipantMailer.exchange_reminder(self).deliver
  end
end
