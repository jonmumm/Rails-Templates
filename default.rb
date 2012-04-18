gem "haml-rails"

gem "rspec-rails", :group => [:development, :test]
run "rm -r test"

gem "factory_girl", :group => [:development, :test]
gem "spork", "~> 1.0rc", :group => [:development, :test]

gem "pg", :group => :production
gem "thin", :group => :production
gem 'sqlite3', :group => [:development, :test]

gem "nifty-generators", :group => :development

run "bundle install"

generate "nifty:layout --haml"
run "rm app/views/layouts/application.html.erb"
generate "rspec:install"
run "spork rspec --bootstrap"

if yes?("Install backbone?")
  gem "rails-backbone"
  run "bundle install"
  generate "backbone:install"
end

run "rm public/index.html"

git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"
