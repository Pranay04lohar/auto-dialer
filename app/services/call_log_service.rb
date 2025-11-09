require 'securerandom'

class CallLogService
  @@logs = []  # Class variable (in-memory storage)
  
  def self.add(phone_number, call_sid, status = 'initiated')
    log_entry = {
      id: SecureRandom.hex(8),
      phone: phone_number,
      call_sid: call_sid,
      status: status,
      duration: 0,
      created_at: Time.now,
      updated_at: Time.now
    }
    
    @@logs << log_entry
    @@logs = @@logs.last(1000)  # Keep last 1000 calls
    
    log_entry
  end
  
  def self.update_status(call_sid:, status:, duration: 0, to: nil, from: nil)
    log_entry = @@logs.find { |log| log[:call_sid] == call_sid }
    
    if log_entry
      log_entry[:status] = status
      log_entry[:duration] = duration
      log_entry[:to] = to if to
      log_entry[:from] = from if from
      log_entry[:updated_at] = Time.now
    end
    
    log_entry
  end
  
  def self.all
    @@logs
  end
  
  def self.find_by_call_sid(call_sid)
    @@logs.find { |log| log[:call_sid] == call_sid }
  end
  
  def self.stats
    total = @@logs.count
    completed = @@logs.count { |l| l[:status] == 'completed' }
    failed = @@logs.count { |l| ['failed', 'busy', 'no-answer', 'canceled'].include?(l[:status]) }
    answered = @@logs.count { |l| l[:status] == 'answered' }
    
    {
      total: total,
      completed: completed,
      answered: answered,
      failed: failed,
      success_rate: total > 0 ? ((completed.to_f / total) * 100).round(2) : 0
    }
  end
  
  def self.clear
    @@logs = []
  end
end

