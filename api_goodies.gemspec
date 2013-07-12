# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_goodies/version'

Gem::Specification.new do |spec|
  spec.name          = "api_goodies"
  spec.version       = APIGoodies::VERSION
  spec.authors       = ["Shopkeep"]
  spec.email         = ["developers@shopkeep.com"]
  spec.description   = %q{Common}
  spec.summary       = %q{Common}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "appraisal", "~> 0.5.1"
  spec.add_development_dependency "pry-nav"
  spec.add_runtime_dependency "rspec"
  spec.add_runtime_dependency "uuid"
  spec.add_runtime_dependency "rake"
  spec.add_runtime_dependency "rspec-rails", "~> 2.0"
  spec.add_runtime_dependency "activerecord", ">= 3.2.0"
  spec.add_runtime_dependency "activesupport", ">= 3.2.0"
  if RUBY_PLATFORM == 'java'
    spec.add_runtime_dependency 'activerecord-jdbcsqlite3-adapter'
    spec.add_runtime_dependency 'jruby-openssl'
  else
    spec.add_runtime_dependency "sqlite3"
  end
  spec.add_runtime_dependency "shoulda-matchers", "~> 1.3.0"
  spec.add_runtime_dependency "rake-hooks", "~> 1.0"
  spec.add_runtime_dependency "uuid"
end
