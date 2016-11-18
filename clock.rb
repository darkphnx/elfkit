require_relative './config/boot'
require_relative './config/environment'

module Clockwork
  handler do |job|
    job_klass = job.constantize
    job_klass.perform_later
  end

  every(1.day, 'SendReminderEmailsJob', at: '09:00')
  every(1.hour, 'MatchParticipantsJob', at: '**:00')
  every(1.hour, 'CompleteExchangeJob', at: '**:00')
end
