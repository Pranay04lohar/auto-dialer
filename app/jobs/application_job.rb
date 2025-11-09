class ApplicationJob < ActiveJob::Base
  # Most jobs are safe to ignore if there's an error
  discard_on StandardError
end

