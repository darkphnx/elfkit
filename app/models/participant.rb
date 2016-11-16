class Participant < ApplicationRecord
  include RandomPermalink

  belongs_to :exchange

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
end
