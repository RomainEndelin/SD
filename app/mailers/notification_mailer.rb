class NotificationMailer < ApplicationMailer
  def notification_email(notification)
    @user = notification.user
    @content = notification.message
    @title = notification.message
    @url = @user.admin? ? notification.admin_path : notification.path
    mail(to: @user.email, subject: @title)
  end
end
