require 'dotenv/load'
class UserMailer < ApplicationMailer

  after_action :set_delivery_options

  default from: "me@mydomain.com"

  def registration_confirmation(user)
    @user = user
    @base_url = ENV['BASE_URL']
    mail to: "#{user.name} <#{user.email}>",
         subject: "Registration Confirmation"
  end

  def forgot_password(user)
    @user = user
    mail to: user.email, subject: "Reset your password"
  end

  private

  def set_delivery_options
    mail.delivery_method :smtp,
                         {
                           address: "smtp.gmail.com",
                           port: 587,
                           domain: "dafbin-staging.fly.dev",
                           user_name: "dafbin.qatros@gmail.com",
                           password: "vxmqlztxgvtoawxl",
                           authentication: "plain",
                           enable_starttls_auto: true,
                           open_timeout: 5,
                           read_timeout: 5
                         }
  end
end
