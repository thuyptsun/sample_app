source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.1"

gem "bcrypt", "3.1.13"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap-sass", "3.4.1"
gem "bootstrap4-kaminari-views", "~> 1.0.1"
gem "carrierwave", "0.10.0"
gem "config", ">= 2.2.1"
gem "faker", "2.1.2"
gem "figaro"
gem "fog", "1.36.0"
gem "jbuilder", "~> 2.7"
gem "kaminari", "~> 1.2.1"
gem "mini_magick", "4.9.5"
gem "mysql2", "0.5.3"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.2", ">= 6.0.2.2"
gem "rails-i18n", ">=6.0.0"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
group :development, :test do
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end
