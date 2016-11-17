class ParticipantMailerPreview < ActionMailer::Preview
  def confirm_participant
    ParticipantMailer.confirm_participation(Participant.first)
  end

  def exchange_reminder
    ParticipantMailer.exchange_reminder(Participant.first)
  end

  def match_ready
    ParticipantMailer.match_ready(Participant.first)
  end

  def match_reminder
    ParticipantMailer.match_reminder(Participant.first)
  end
end