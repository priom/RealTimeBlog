source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'autoprefixer-rails', '~> 7.0', '>= 7.0.1'
gem 'devise', '~> 4.2'
gem 'devise-bootstrap-views', '~> 0.0.11'


group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.6'
  gem 'byebug', platform: :mri
end

group :test do
  gem 'capybara', '~> 2.14'
end

group :production do
  gem 'pg'
  gem 'redis'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard', '~> 2.14'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'guard-cucumber', '~> 2.1', '>= 2.1.2'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
