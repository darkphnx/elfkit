class ParticipantMatch < ApplicationRecord
  belongs_to :exchange
  belongs_to :gifter, class_name: "Participant"
  belongs_to :giftee, class_name: "Participant"
end
