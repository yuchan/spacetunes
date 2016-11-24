# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spacetunes/version'

Gem::Specification.new do |spec|
  spec.name          = "spacetunes"
  spec.version       = Spacetunes::VERSION
  spec.authors       = ["Yusuke Ohashi"]
  spec.email         = ["github@junkpiano.me"]

  spec.summary       = %q{make it easy to view itunesconnect data}
  spec.description   = %q{It provides utility command to view itunes connect data. It will free you by unclattering your daily jobs.}
  spec.homepage      = "https://github.com/yuchan/spacetunes"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "redcarpet"
  spec.add_development_dependency "spaceship"
end