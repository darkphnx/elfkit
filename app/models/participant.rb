class Participant < ApplicationRecord
  include RandomPermalink

  belongs_to :exchange

  has_one :participant_match, foreign_key: :gifter_id, dependent: :destroy
  has_one :giftee, through: :participant_match

  validates :name, presence: true, uniqueness: { scope: :exchange_id, message: "is already used by someone else in " \
    "this exchange, please add some differentiator such as a second initial." }
  validates :email_address, presence: true, uniqueness: { scope: :exchange_id, message: "is already signed up to " \
    "this exchange" }, format: /.+\@.+\..+/
  validates :login_token, presence: true

  before_validation do
    self.login_token ||= SecureRandom.urlsafe_base64
  end

  after_create :send_confirmation_email

  scope :participating, -> { where(participating: true) }
  scope :unconfirmed, -> { where(participating: nil) }
  scope :not_participating, -> { where(participating: false) }

  def self.login(permalink, login_token)
    matches = where(permalink: permalink, login_token: login_token)
    matches.first
  end

  def activity!
    # First time we have recorded activity for this participant, set them as participating
    self.participating = true if last_activity_at.nil?

    self.last_activity_at = Time.now.utc
    save(validate: false)
  end

  def email_tag
    "#{name} <#{email_address}>"
  end

  def send_confirmation_email
    ParticipantMailer.confirm_participation(self).deliver_later
  end

  def send_match_ready_email
    ParticipantMailer.match_ready(self).deliver_later
  end

  def send_exchange_reminder_email
    ParticipantMailer.exchange_reminder(self).deliver_later
  end

  def send_match_reminder_email
    ParticipantMailer.match_reminder(self).deliver_later
  end
end
