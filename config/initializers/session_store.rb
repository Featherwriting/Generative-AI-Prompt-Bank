require 'rack-cas/session_store/rails/active_record'
Rails.application.config.x.session_cookie_name = (Rails.env.production? ? '_APP_NAME_session_id' : "_APP_NAME_#{Rails.env}_session_id")

Rails.application.config.action_dispatch.cookies_same_site_protection = :lax

Rails.application.config.session_store ActionDispatch::Session::RackCasActiveRecordStore,
  key: Rails.application.config.x.session_cookie_name,
  secure: !Rails.env.development? && !Rails.env.test?,
  httponly: true
