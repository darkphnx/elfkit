class Participant < ApplicationRecord
  include RandomPermalink

  belongs_to :exchange

  validates :name, presence: true
  validates :email_address, presence: true
  validates :login_token, presence: true

  before_validation do
    self.login_token ||= SecureRandom.urlsafe_base64
  end
end
