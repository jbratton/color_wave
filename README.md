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

    $ color_wave --lines 20 --cycles 3 --speed 10.0

The above values are the defaults.
##### Options
* `--lines` - the height of the wave in terminal lines
* `--cycles` - how many cycles of the wave will be drawn
* `--speed` - used as the divisor of the delay time between drawing loops; use higher values for faster redrawing
* `--help` - show usage information

You can use it in Ruby too:
```ruby
require 'color_wave'

ColorWave.new(lines: 10, cycles: 2, speed: 1, colors: %w( ff0000 00ff00 0000ff ), chars: %w( _ / ^ \ )).run
```

The `speed` option is used as the divisor to a `BASE_SLEEP_TIME` constant so higher speeds will redraw the wave more quickly. The `colors` and `chars` options specify the colors and characters to be cycled through when drawing the wave.

`Ctrl-C` will stop it once it's running.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jbratton/color_wave. This project is intended to be a safe, welcoming space for collaboration and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
