source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 2.7.0'

gem 'rails', '~> 7.0'
# Use WEBrick instead of Puma (no MSYS2 needed, but slower)
# gem 'puma', '~> 5.0'  # Requires MSYS2 on Windows
gem 'webrick', '~> 1.7'  # Pure Ruby, no native extensions
gem 'twilio-ruby', '~> 5.0'
gem 'httparty', '~> 0.21'
gem 'dotenv-rails', '~> 2.8'
gem 'actionpack', '~> 7.0'
gem 'activesupport', '~> 7.0'
gem 'activejob', '~> 7.0'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
end

