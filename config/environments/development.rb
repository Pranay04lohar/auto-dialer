Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.active_support.deprecation = :log
  
  # Allow ngrok and other tunneling services
  config.hosts << "kiana-deflationary-untenuously.ngrok-free.dev"
  config.hosts << /.*\.ngrok-free\.dev/
  config.hosts << /.*\.ngrok\.io/
end


