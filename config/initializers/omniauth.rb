Rails.application.config.middleware.use OmniAuth::Builder do
  provider :meetup, ENV['n5qbl8a65gcmjlp8v779sm66o4'], ENV['enqesvtmg4d9h7kojk91bn0cb4']
end