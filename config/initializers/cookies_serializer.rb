Rails.application.config.action_dispatch.cookies_serializer = :json
Rails.application.config.action_dispatch.encrypted_cookie_salt = ENV['SESSION_ENCRYPTED_COOKIE_SALT']
Rails.application.config.action_dispatch.encrypted_signed_cookie_salt = ENV['SESSION_ENCRYPTED_SIGNED_COOKIE_SALT']
