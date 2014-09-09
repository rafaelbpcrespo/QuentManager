ActionMailer::Base.smtp_settings = 
  {

    :address            => 'smtp.gmail.com',
    :port               => 587,
    :domain             => 'gmail.com', #you can also use google.com
    :authentication     => :plain,
    :user_name          => 'pedidossiquitutes@gmail.com',
    :password           => 'siquitutes123',
    :enable_starttls_auto => true
}
