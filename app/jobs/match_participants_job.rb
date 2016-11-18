class MatchParticipantsJob < ApplicationJob
  def perform
    Exchange.require_matching.each(&:match!)
  end
end
