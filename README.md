# ColorWave

Creates a color-cycling wave of characters in the terminal. All-in-all pretty useless.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'color_wave'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install color_wave

## Usage

You can run it from the command line with or without some options:

    $ color_wave --lines 10 --cycles 2

You can use it in Ruby too:
```ruby
require 'color_wave'

ColorWave.new(lines: 10, cycles: 2, colors: %w( ff0000 00ff00 0000ff ), chars: %w( _ / ^ \ )).run
```

`Ctrl-C` will stop it once it's running.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jbratton/color_wave. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
