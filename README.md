# Rory::Newrelic

Newrelic instrumentation for the popular Rory framework

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rory-newrelic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rory-newrelic

## Usage

in your `application.rb` drop this code:

```ruby
require 'rory/newrelic'
Rory::NewRelic.hook_application
```

if you need to change where the controllers folder is, the application to use, or which environments to initialize, you can do so using a configure block.

```ruby
Rory::NewRelic.configure do |c|
  c.application = Rory::Application.instance
  c.controllers_folder = "#{Rory.root}/controllers"
  c.environments = %w(production development test)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rory-newrelic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
