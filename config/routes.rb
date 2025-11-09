Rails.application.routes.draw do
  root 'home#index'
  post 'ai_prompt', to: 'home#ai_prompt'
  post 'upload_numbers', to: 'home#upload_numbers'
  delete 'clear_logs', to: 'home#clear_logs'
  
  # Twilio webhooks
  post 'webhooks/twiml', to: 'webhooks#twiml'
  post 'webhooks/status', to: 'webhooks#status'
end



