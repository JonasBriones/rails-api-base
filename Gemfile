# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 8.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '>= 2.1', group: :production
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'database_cleaner-active_record', '~> 2.1'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'faker', '~> 3.2'
  gem 'rspec-rails', '~> 6.1'

  # Linters y seguridad
  gem 'brakeman', '~> 6.0', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  # Reportes de pruebas
  gem 'rspec_junit_formatter', '~> 0.6', require: false

  # Configuración de entorno
  gem 'dotenv-rails', '~> 2.8'
end

group :test do
  gem 'json_spec', '~> 1.1'
  gem 'shoulda-matchers', '~> 6.0'
  gem 'simplecov', '~> 0.22', require: false
  gem 'simplecov-cobertura', '~> 2.1', require: false
end

gem 'bcrypt', '~> 3.1'
gem 'jwt', '~> 2.7'
gem 'omniauth-google-oauth2'
gem 'omniauth-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pundit'
gem 'redis', '~> 5.0'
gem 'pg'