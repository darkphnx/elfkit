class Exchange < ApplicationRecord
  include RandomPermalink

  has_many :participants
  has_many :participant_matches

  validates :title, presence: true
  validates :permalink, presence: true
end
