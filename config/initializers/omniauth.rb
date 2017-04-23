OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_PASSWD'], {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end