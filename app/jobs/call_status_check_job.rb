class CallStatusCheckJob < ApplicationJob
  queue_as :default

  def perform(call_sid, phone_number)
    # Wait a bit for the call to process
    sleep(2)
    
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    
    return if account_sid.blank? || auth_token.blank?
    
    begin
      client = Twilio::REST::Client.new(account_sid, auth_token)
      call = client.calls(call_sid).fetch
      
      # Update call log with actual status
      CallLogService.update_status(
        call_sid: call_sid,
        status: call.status,
        duration: call.duration.to_i,
        to: call.to,
        from: call.from
      )
      
      puts "=" * 50
      puts "STATUS CHECK:"
      puts "Call SID: #{call_sid}"
      puts "Status: #{call.status}"
      puts "Duration: #{call.duration}"
      puts "=" * 50
      
    rescue Twilio::REST::RestError => e
      # If using test credentials, simulate status based on test number
      if e.code == 20008 || e.message.include?("Test Account")
        simulate_test_status(call_sid, phone_number)
      else
        puts "Failed to check status for #{call_sid}: #{e.message}"
      end
    rescue => e
      puts "Failed to check status for #{call_sid}: #{e.message}"
    end
  end

  private

  def simulate_test_status(call_sid, phone_number)
    # Simulate status based on Twilio test number patterns
    status = case phone_number
    when '+15005550006'
      'completed'  # Always answers
    when '+15005550001'
      'busy'       # Always busy
    when '+15005550002'
      'no-answer'  # Always no answer
    when '+15005550003'
      'failed'    # Always fails
    when '+15005550004'
      'failed'    # Invalid number
    when '+15005550005'
      'failed'    # Unreachable
    else
      'completed'  # Default to completed for other test numbers
    end

    CallLogService.update_status(
      call_sid: call_sid,
      status: status,
      duration: status == 'completed' ? 5 : 0,
      to: phone_number,
      from: ENV['TWILIO_PHONE_NUMBER']
    )

    puts "=" * 50
    puts "SIMULATED STATUS (Test Credentials):"
    puts "Call SID: #{call_sid}"
    puts "Status: #{status}"
    puts "Duration: #{status == 'completed' ? 5 : 0}"
    puts "=" * 50
  end
end

