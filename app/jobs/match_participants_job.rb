class MatchParticipantsJob < ApplicationJob
  def perform
    Exchange.require_matching.each(&:pair_participants!)
  end
end
