ActionMailer::Base.smtp_settings = 
  {


    :address            => 'smtp.uhserver.com',
    :port               => 587,
    :domain             => 'siquitutes.com', #you can also use google.com
    :authentication     => :plain,
    :user_name          => 'contato@siquitutes.com',
    :password           => 'vanessa1',
    :enable_starttls_auto => true
}
