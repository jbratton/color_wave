# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'color_wave/version'

Gem::Specification.new do |spec|
  spec.name          = "color_wave"
  spec.version       = ColorWave::VERSION
  spec.authors       = ["jbratton"]
  spec.email         = ["jeremy@alumni.rice.edu"]

  spec.summary       = %q{Create a colored wave of characters in your terminal.}
  spec.homepage      = "https://github.com/jbratton/color_wave"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  
  spec.add_runtime_dependency 'pry'
  spec.add_runtime_dependency 'rainbow', '~> 2.1.0'
  spec.add_runtime_dependency 'ruby-terminfo', '~> 0.1.1'
  spec.add_runtime_dependency 'trollop', '~> 2.1.2'
  spec.add_runtime_dependency 'tty-cursor', '~> 0.3.0'
end
