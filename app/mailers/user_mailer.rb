class UserMailer < ActionMailer::Base
  default from: 'from@example.com'

  def email_changed(user)
    # Sending email
  end
end