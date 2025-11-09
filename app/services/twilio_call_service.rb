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
      call = client.calls.create(
        to: phone_number,
        from: from_number,
        url: twiml_url,
        status_callback: status_callback,
        status_callback_event: ['initiated', 'ringing', 'answered', 'completed'],
        status_callback_method: 'POST'
      )
      
      call.sid
    rescue Twilio::REST::RestError => e
      Rails.logger.error "Twilio error: #{e.message}"
      raise "Failed to initiate call: #{e.message}"
    end
  end
end



