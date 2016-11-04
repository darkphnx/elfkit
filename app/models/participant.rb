class Participant < ApplicationRecord
  include RandomPermalink
  
  belongs_to :exchange

  validates :name, presence: true
  validates :email_address, presence: true
end
