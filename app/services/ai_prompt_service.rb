class AiPromptService
  def self.parse(command)
    # Simple regex-based parser (fast and free)
    # Can be enhanced with OpenAI API later
    
    # Extract phone number from command
    phone = extract_phone_number(command)
    
    # Determine action
    action = determine_action(command)
    
    {
      action: action,
      phone: phone
    }
  end

  private

  def self.extract_phone_number(text)
    # Try to find phone number in various formats
    # +91 9876543210
    # 91 9876543210
    # 9876543210
    # 1800-XXX-XXXX (test numbers)
    # +14199098738 (US numbers)
    
    # First, try to find +1500555xxxx (Twilio test numbers)
    test_number = text.match(/\+?1[ -]?800[ -]?\d{3}[ -]?\d{4}/i) || 
                   text.match(/\+?1[ -]?500[ -]?555[ -]?\d{4}/i)
    
    return normalize_phone(test_number[0]) if test_number
    
    # Try US/Canada format with +1 (10-11 digits after +1)
    us_number = text.match(/\+1\d{10,11}/) || 
                text.match(/\+1[ -]?\d{3}[ -]?\d{3}[ -]?\d{4}/)
    
    return normalize_phone(us_number[0]) if us_number
    
    # Try Indian format
    indian_number = text.match(/\+?91[ -]?\d{10}/) || 
                    text.match(/\d{10}/)
    
    return normalize_phone(indian_number[0]) if indian_number
    
    # Try any phone number format (improved regex to capture full number)
    # Match + followed by digits, or digits with optional spaces/dashes
    any_number = text.match(/\+?\d[\d\s\-\(\)]{9,}/)
    
    return normalize_phone(any_number[0]) if any_number
    
    nil
  end

  def self.normalize_phone(phone)
    return nil unless phone
    
    # Remove all non-digits except +
    cleaned = phone.gsub(/[^\d+]/, '')
    
    # Add + if missing and it's a long number
    if cleaned.length >= 10 && !cleaned.start_with?('+')
      # If starts with 1 (US) or 91 (India), add +
      if cleaned.start_with?('1') || cleaned.start_with?('91')
        cleaned = '+' + cleaned
      elsif cleaned.length == 10
        # Assume Indian number
        cleaned = '+91' + cleaned
      end
    end
    
    cleaned
  end

  def self.determine_action(text)
    text_lower = text.downcase
    
    if text_lower.include?('call') || text_lower.include?('dial')
      'call'
    elsif text_lower.include?('cancel') || text_lower.include?('stop')
      'cancel'
    else
      'call'  # Default action
    end
  end
end


