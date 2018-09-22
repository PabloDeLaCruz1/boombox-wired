source 'https://rubygems.org'

# this will install/run on all environments
gem 'sinatra'
gem 'activerecord'
gem 'pg'

# this gem allows us to utilize the set :database, 
#   'set :database, "postgresql:[database name]"
gem 'sinatra-activerecord'

# this gem allows us to execute activerecord
#   migration commands
gem 'rake'


# this will only install/run on development environments
group :development do
  gem "byebug"
    gem "rails-erd"

end

# this will only install/run on test environments
group :test do
  gem "faker"
  gem "rspec"
end

# this will only install/run on production environments
group :production do
  gem "rollbar"
end