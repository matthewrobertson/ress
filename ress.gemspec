# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ress/version'

Gem::Specification.new do |gem|
  gem.name          = "ress"
  gem.version       = Ress::VERSION
  gem.authors       = ["Matthew Robertson"]
  gem.email         = ["matthewrobertson03@gmail.com"]
  gem.description   = %q{Progressively enhance the mobile user experience of your Rails application.}
  gem.summary       = %q{Progressively enhance the mobile user experience of your Rails application.}
  gem.homepage      = "https://github.com/matthewrobertson/ress"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("actionpack", "~> 3.0")

  gem.add_development_dependency("rspec")
end
