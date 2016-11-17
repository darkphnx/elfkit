class SendReminderEmailsJob < ApplicationJob
  def perform
    Exchange.require_match_reminder_sending.each(&:send_match_reminder_emails)
    Exchange.require_exchange_reminder_sending.each(&:send_exchange_reminder_emails)
  end
end
