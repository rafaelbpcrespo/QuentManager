ActionMailer::Base.smtp_settings = 
  {

    :address            => 'smtp.gmail.com',
    :port               => 587,
    :domain             => 'gmail.com', #you can also use google.com
    :authentication     => :plain,
    :user_name          => 'rafaelbpcrespo@gmail.com',
    :password           => '17rafa12R',
    :enable_starttls_auto => true
}