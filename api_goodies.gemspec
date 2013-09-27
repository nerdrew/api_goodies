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
  spec.post_install_message = <<-EOM
    Rubygems does not support conditional dependencies, hence
    this gem cannot support jruby + mri. This gem requires sqlite
    to work. You must install one of the following:

    JRuby: `gem install activerecord-jdbcsqlite3-adapter`

    MRI: `gem install sqlite3`
  EOM

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "appraisal", "~> 0.5.1"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "rspec-rails", "~> 2.0"
  spec.add_development_dependency "shoulda-matchers", "~> 2.4.0"
  spec.add_development_dependency "rake-hooks", "~> 1.0"
  spec.add_runtime_dependency "uuid"
  spec.add_runtime_dependency "rake"
  spec.add_runtime_dependency "activerecord", ">= 3.2.0"
  spec.add_runtime_dependency "activesupport", ">= 3.2.0"
end

