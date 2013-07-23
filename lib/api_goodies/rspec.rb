require 'api_goodies'

RSpec.configure do |config|
  require 'api_goodies/anonymous_model'
  require 'api_goodies/rspec/shared_examples/has_uuid'
  require 'api_goodies/rspec/shared_examples/is_soft_deletable'
  require 'api_goodies/rspec/shared_examples/belongs_to_with'
  require 'api_goodies/rspec/shared_examples/has_and_belongs_to_many_with'
  require 'api_goodies/rspec/shared_examples/has_default_status'
  require 'api_goodies/rspec/shared_examples/scope_uuid'
  require 'api_goodies/rspec/helpers'
  config.extend APIGoodies::AnonymousModel
  config.extend APIGoodies::RSpec::Helpers
end

module APIGoodies
  module RSpec
  end
end
