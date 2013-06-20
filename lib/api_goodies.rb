require "api_goodies/version"
require 'active_record'
require 'active_support/inflector'
if ActiveSupport::VERSION::MAJOR < 4
  require 'active_support/core_ext/logger'
end
require 'api_goodies/belongs_to_with'
require 'api_goodies/has_uuid'
require 'api_goodies/is_soft_deletable'
require 'api_goodies/has_default_status'

ActiveSupport.on_load(:active_record) do
  extend APIGoodies::HasUuid
  extend APIGoodies::IsSoftDeletable
  extend APIGoodies::BelongsToWith
  extend APIGoodies::HasDefaultStatus
end

require 'api_goodies/railtie' if $rails_rake_task

module APIGoodies
end

require 'pry-nav'
