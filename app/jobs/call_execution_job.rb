class CallExecutionJob < ApplicationJob
  queue_as :default

  def perform(phone_number)
    Rails.logger.info "Initiating call to #{phone_number}"
    
    begin
      call_sid = TwilioCallService.call(phone_number)
      
      # Add to call log
      CallLogService.add(phone_number, call_sid, 'initiated')
      
      Rails.logger.info "Call initiated: #{call_sid} to #{phone_number}"
    rescue => e
      error_message = e.message
      Rails.logger.error "Failed to call #{phone_number}: #{error_message}"
      puts "=" * 50
      puts "TWILIO ERROR: #{error_message}"
      puts "=" * 50
      
      # Add failed call to log with error message
      CallLogService.add(phone_number, nil, 'failed')
      
      # Don't raise - just log the error
    end
  end
end



