class TwilioCallService
  def self.call(phone_number, message = nil)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    from_number = ENV['TWILIO_PHONE_NUMBER']
    
    if account_sid.blank? || auth_token.blank? || from_number.blank?
      raise "Twilio credentials not configured. Please set TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, and TWILIO_PHONE_NUMBER in .env file"
    end

    client = Twilio::REST::Client.new(account_sid, auth_token)
    
    # Build TwiML URL
    base_url = ENV['BASE_URL'] || 'http://localhost:3000'
    twiml_url = "#{base_url}/webhooks/twiml"
    twiml_url += "?message=#{CGI.escape(message)}" if message.present?
    
    # Status callback URL
    status_callback = "#{base_url}/webhooks/status"
    
    begin
      # Check if using test credentials with real number
      if account_sid.start_with?('AC') && !phone_number.start_with?('+1500555')
        # Check if it's a test account SID (test accounts have specific patterns)
        # Note: This is a heuristic - test accounts might work differently
        puts "=" * 50
        puts "INFO: Making call to real number: #{phone_number}"
        puts "Using Account SID: #{account_sid[0..10]}..."
        puts "=" * 50
      end
      
      call = client.calls.create(
        to: phone_number,
        from: from_number,
        url: twiml_url,
        status_callback: status_callback,
        status_callback_event: ['initiated', 'ringing', 'answered', 'completed'],
        status_callback_method: 'POST'
      )
      
      puts "=" * 50
      puts "CALL INITIATED:"
      puts "Call SID: #{call.sid}"
      puts "To: #{phone_number}"
      puts "From: #{from_number}"
      puts "Status: #{call.status}"
      puts "=" * 50
      
      call.sid
    rescue Twilio::REST::RestError => e
      Rails.logger.error "Twilio error: #{e.message}"
      
      # Special warning for test credentials with real numbers
      if e.code == 20008 || e.message.include?("Test Account")
        puts "=" * 50
        puts "ERROR: Test credentials detected!"
        puts "Test credentials don't make real calls to real numbers."
        puts "To make real calls:"
        puts "1. Use LIVE credentials (not test credentials)"
        puts "2. Verify the phone number in Twilio Console"
        puts "3. Update .env with LIVE Account SID and Auth Token"
        puts "=" * 50
      end
      
      raise "Failed to initiate call: #{e.message}"
    end
  end
end



