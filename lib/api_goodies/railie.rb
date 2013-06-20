class APIGoodies::Railtie < Rails::Railtie
  rake_tasks do
    load 'api_goodies/tasks/schema.rake'
  end
end
