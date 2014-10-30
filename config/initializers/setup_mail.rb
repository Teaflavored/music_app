ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            'music.app.dev.aa@gmail.com',
  password:             '\][poiuy',
  authentication:       'plain',
  enable_starttls_auto: true
}