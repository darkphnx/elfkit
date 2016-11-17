class ApplicationMailer < ActionMailer::Base
  default from: 'Secret Santa <santa@elfk.it>'
  layout 'mailer'
end
