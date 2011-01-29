# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_xxx_session',
  :secret      => '4028a1b966844250cc810acb1b46339c4ce35f8b686a1e1e6dfc0c0632dde75ec1c51e4bece51bfeba0890be6af580507400a9d85deeb59f4ae4c2ae83587954'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
