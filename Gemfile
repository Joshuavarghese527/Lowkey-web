source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.6'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bootstrap-sass', '~> 3.3.7'
gem 'devise', '~> 4.4', '>= 4.4.1'

gem 'toastr-rails'

gem "figaro"

gem 'omniauth'
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"

#fontawesome
gem 'font-awesome-sass'

gem 'activeadmin'
gem 'active_skin' 


gem 'paperclip', '~> 5.1.0'
gem 'aws-sdk', '~> 2.8'

gem 'geocoder', '~> 1.4'
gem 'jquery-ui-rails', '~> 5.0'

gem 'ransack', '~> 1.7'

gem 'jquery-timepicker-addon-rails'

gem 'twilio-ruby', '4.11.1'

gem 'stripe', '~> 3.0.0'
gem 'rails-assets-card', source: 'https://rails-assets.org'

gem 'rails_12factor', group: :production