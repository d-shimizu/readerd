namespace :generate_secret_token do
  #secret_token_file = Rails.root.join('config', 'initializers', 'secret_token.rb')
  secret_token_file = Rails.root.join('lib', 'secrets.yml')

  #file secret_token_file do
    require 'securerandom'
    token = SecureRandom.hex(64)

    require 'active_support/core_ext/string/strip'
    application_name = Rails.application.class.name
#    content = <<-EOS.strip_heredoc
#{application_name}.config.secret_key_base = '#{token}'
#    EOS
    p secret_token_file

    if ENV['RAILS_ENV']=="development" then
    content = <<-EOS.strip_heredoc
development:
    secret_key_base: #{token}
test:
    secret_key_base: 
production:
    secret_key_base: 
    EOS
    elsif ENV['RAILS_ENV']=="test" then
    content = <<-EOS.strip_heredoc
development:
    secret_key_base: 
test:
    secret_key_base: #{token}
production:
    secret_key_base: 
    EOS
    elsif ENV['RAILS_ENV']=="production" then
    content = <<-EOS.strip_heredoc
development:
    secret_key_base: 
test:
    secret_key_base: 
production:
    secret_key_base: #{token}
    EOS
    end

    if content!=nil then
      secret_token_file.open('w') do |f|
        f.write(content)
        puts "Generated secret token and write it to #{secret_token_file.relative_path_from(Rails.root)}"
      end
    else
      p "Usage:  bundle exec rake generate_secret_token:generate RAILS_ENV=develpment|test|production"
    end

  #end

  desc 'Generate secret token'
  task generate: secret_token_file
end
