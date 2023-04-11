class UserMailer < ApplicationMailer
  default :from => "me@mydomain.com"
  def registration_confirmation(user)
      @user = user
      mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
  end

  def forgot_password(user)
    @user = user 
    mail to: user.email, subject: 'Reset your password'
  end
  
end
