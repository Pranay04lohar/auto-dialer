class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def twiml
    # Generate TwiML for the call
    message = params[:message] || "Hello, this is an automated call from Autodialer. Thank you for your time."
    
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say(voice: 'alice', message: message)
      r.hangup
    end

    render xml: response.to_s
  end

  def status
    # Handle Twilio status callbacks
    call_sid = params[:CallSid]
    call_status = params[:CallStatus]
    call_duration = params[:CallDuration] || 0
    to_number = params[:To]
    from_number = params[:From]

    puts "=" * 50
    puts "WEBHOOK RECEIVED:"
    puts "Call SID: #{call_sid}"
    puts "Status: #{call_status}"
    puts "Duration: #{call_duration}"
    puts "=" * 50

    # Update call log
    CallLogService.update_status(
      call_sid: call_sid,
      status: call_status,
      duration: call_duration.to_i,
      to: to_number,
      from: from_number
    )

    head :ok
  end
end



