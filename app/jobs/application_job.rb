class ApplicationJob < ActiveJob::Base
  sidekiq_options queue: "default"
  sidekiq_options backtrace: true
end
