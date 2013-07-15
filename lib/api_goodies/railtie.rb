module APIGoodies
  class Railtie < Rails::Railtie
    initializer 'api_goodies.initializer' do
      ActiveSupport.on_load(:active_record) do
        extend APIGoodies::HasUuid
        extend APIGoodies::IsSoftDeletable
        extend APIGoodies::BelongsToWith
        extend APIGoodies::HasDefaultStatus
        extend APIGoodies::ScopeUUID
      end
    end

    rake_tasks do
      # Don't load this automatically
      #load 'api_goodies/tasks/schema.rake'
    end
  end
end
