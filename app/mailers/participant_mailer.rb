class ParticipantMailer < ApplicationMailer
  def confirm_participation(participant)
    @participant = participant
    @exchange = participant.exchange

    mail to: @participant.email_tag, subject: "#{@exchange.title} - Confirm your participation"
  end

  def match_reminder(participant)
    @participant = participant
    @exchange = participant.exchange

    mail to: @participant.email_tag, subject: "#{@exchange.title} - It's nearly matching time!"
  end

  def match_ready(participant)
    @participant = participant
    @exchange = participant.exchange

    mail to: @participant.email_tag, subject: "#{@exchange.title} - Your match is ready!"
  end

  def exchange_reminder(participant)
    @participant = participant
    @exchange = participant.exchange

    mail to: @participant.email_tag, subject: "#{@exchange.title} - It's nearly gifting time!"
  end
end
