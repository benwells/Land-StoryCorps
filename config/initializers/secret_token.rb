# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# Landstorycorps::Application.config.secret_key_base = '4e0bbde457fe53f9cf6bcbd8872395d3b24fb24ba20090f77959be0852531cb3f7d9aa469240b93970c2c64124a584c28e50971ee57e494ccb76e38455724cd8'
Landstorycorps::Application.config.secret_key_base = if Rails.env.development? or Rails.env.test?
  ('x' * 30) # meets minimum requirement of 30 chars long
else
  ENV['SECRET_TOKEN']
end
