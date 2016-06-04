# frozen_string_literal: true

require 'rainbow'
require 'tty-cursor'
require 'terminfo'

class ColorWave
  DEFAULT_LINES = 20
  DEFAULT_CHARS = %w( O ).freeze
  DEFAULT_CYCLES = 3

  # rainbow RGB values stolen from Term-Colormap on CPAN
  # https://metacpan.org/source/XXFELIXXX/Term-Colormap-0.06/lib/Term/Colormap.pm
  DEFAULT_COLORS = %w(
    800000 ff0000 ff5f00 ff8700 ffaf00 ffd700 ffff00 ffff00
    d7ff00 afff00 87ff00 5fff00 00ff00 00ff00 00ff5f 00ff87
    00ffaf 00ffd7 00ffff 00ffff 00d7ff 00afff 0087ff 005fff
    0000ff 0000ff 5f00ff 8700ff af00ff d700ff ff00ff 800080
  ).freeze

  TWO_PI = Math::PI * 2
  LOOP_SLEEP = 0.00001

  attr_reader :lines, :cycles, :chars, :colors

  def initialize(lines: DEFAULT_LINES, cycles: DEFAULT_CYCLES,
                 chars: DEFAULT_CHARS, colors: DEFAULT_COLORS)
    @lines = lines
    @cycles = cycles
    @chars = chars.cycle
    @colors = colors.cycle

    @sleep_time = LOOP_SLEEP
    @current_line = 0
    @shutdown = false

    set_signal_handlers
    recalculate_values
  end

  def run
    prepare_screen
    loop.each_with_index do |_, pass|
      break if shutdown
      write_one_pass pass
      ready_next_pass
    end
    cleanup_screen
  end

  private

  attr_accessor :current_line, :cycles, :shutdown, :sleep_time, :wave_rows

  def width
    TermInfo.screen_width
  end

  def prepare_screen
    cursor.hide
    print cursor.clear_screen
    lines.times { || puts }
    self.current_line = 0
  end

  def cleanup_screen
    print cursor.clear_screen
    cursor.show
  end

  def next_line
    wave_rows.next
  end

  def next_char
    chars.next
  end

  def next_color(pass, step)
    colors.take(width)[(pass + step) % width]
  end

  def write_one_pass(pass)
    width.times do |step|
      move_to_line next_line
      print Rainbow(next_char).color(next_color(pass, step))
      sleep sleep_time
    end
  end

  def ready_next_pass
    print "\r"
  end

  def cursor
    @cursor ||= TTY::Cursor
  end

  def recalculate_values
    radians = cycles * TWO_PI
    step_size = radians / width
    wave_samples = 0.step(to: radians, by: step_size).map { |f| Math.sin f }
    self.wave_rows = scale_samples(wave_samples).take(width).cycle
  end

  def scale_samples(wave_samples)
    wave_samples.map do |sample|
      ((sample + 1) * (lines / 2)).round
    end
  end

  def move_to_line(next_line)
    return if next_line == current_line

    if next_line > current_line
      print cursor.up(next_line - current_line)
    else
      print cursor.down(current_line - next_line)
    end
    self.current_line = next_line
  end

  def set_signal_handlers
    %w(INT TERM).each do |signal|
      Signal.trap(signal) do
        self.shutdown = true
      end
    end
  end
end
