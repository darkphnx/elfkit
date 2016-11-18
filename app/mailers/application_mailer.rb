class ApplicationMailer < ActionMailer::Base
  default from: 'Robot Secret Santa at Elfkit <santa@elfk.it>'
  layout 'mailer'
end
