role :app, %w[deploy_user@18.216.160.159]
role :web, %w[deploy_user@18.216.160.159]
role :db,  %w[deploy_user@18.216.160.159]

set :ssh_options, {
  keys: [File.join(File.dirname(__FILE__), 'frogogo-ec2-key-pair.pem'),
         '~/frogogo-ec2-key-pair.pem'],
  forward_agent: false,
  auth_methods: %w[publickey password]
}
