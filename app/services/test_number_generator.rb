class TestNumberGenerator
  # Twilio test numbers
  TEST_NUMBERS = [
    '+15005550006',  # Always answers ✅
    '+15005550001',  # Always busy ❌
    '+15005550002',  # Always no answer ❌
    '+15005550003',  # Always fails ❌
    '+15005550004',  # Invalid number ❌
    '+15005550005'   # Unreachable ❌
  ].freeze

  def self.generate(count = 100)
    numbers = []
    count.times do |i|
      # Mix of success and failures
      # ~33% success, ~67% failures
      if i % 3 == 0
        numbers << TEST_NUMBERS[0]  # Success
      else
        numbers << TEST_NUMBERS.sample  # Random failure
      end
    end
    numbers
  end

  def self.random
    TEST_NUMBERS.sample
  end
end



