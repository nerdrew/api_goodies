require "api_goodies/version"
require 'active_record'
require 'active_support/inflector'
if ActiveSupport::VERSION::MAJOR < 4
  require 'active_record/errors'
  require 'active_support/core_ext/logger'
end
require 'api_goodies/belongs_to_with'
require 'api_goodies/has_uuid'
require 'api_goodies/is_soft_deletable'
require 'api_goodies/has_default_status'
require 'api_goodies/scope_uuid'
require 'api_goodies/record_not_found'
require 'api_goodies/railtie' if defined?(Rails::Railtie)

module APIGoodies
end
