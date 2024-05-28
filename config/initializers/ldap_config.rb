source = ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result
ldap_config = if defined?(Psych::VERSION) && Psych::VERSION > '4.0'
  YAML.unsafe_load(source)[Rails.env]
else
  YAML.load(source)[Rails.env]
end

SheffieldLdapLookup::LdapFinder.ldap_config = ldap_config
::Devise.ldap_use_admin_to_bind = true
::Devise.ldap_config = -> do
  config = ldap_config.dup
  config['admin_user'] = config.delete('username')
  config['admin_password'] = config.delete('password')
  config
end
