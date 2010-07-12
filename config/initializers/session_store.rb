# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nyt_fetch_session',
  :secret      => 'c41a075b260a463506691a7a2e67313a5c02f14d9c9e01c11cea9dce5548a4db23e21fcfd352cafe3ff413c506c5f81ed30867f23d3f77a1d3db09b130ff6d02'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
