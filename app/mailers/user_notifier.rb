class UserNotifier < ApplicationMailer
  default :from => 'info@churchofsouthland.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_daily_notification(user, due_text)
    @user = user
    @due_text = due_text
    mail(
      :to => @user.email,
      :subject => '626 Mandate Prayer Notification'
    )
  end
end
