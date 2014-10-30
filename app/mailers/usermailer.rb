class Usermailer < ActionMailer::Base
  default from: "music.app.dev.aa@gmail.com"
  
  def user_activation_email(user)
    @user = user
    @activation_token = @user.activation_token
    mail(to: @user.email, subject: "Welcome")
  end
end
