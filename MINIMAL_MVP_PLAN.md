# Autodialer - Minimal MVP Plan

## 🎯 Goal
Fast implementation that solves the core purpose: AI prompt → Twilio call → Simple logs

**NO DATABASE, NO REDIS, NO COMPLEX SETUP**

---

## 🏗️ Simplified Architecture

### **Storage**: In-Memory (or simple JSON file)
- Store call logs in memory (array/hash)
- Optionally: Save to JSON file for persistence
- Session-based storage (resets on server restart)

### **Background Jobs**: ActiveJob with `:async` adapter
- No Redis needed
- Jobs run in-memory (simple thread pool)
- Perfect for MVP

### **UI**: Single page with 3 sections
1. AI Prompt input
2. Phone number upload/paste
3. Call logs display

---

## 🔄 Simplified Flow

```
User → "Call to xxxxxx"
  ↓
AI Service (OpenAI) extracts phone number
  ↓
Rails Controller
  ↓
ActiveJob (async, in-memory)
  ↓
Twilio API → Call
  ↓
Webhook → Update in-memory logs
  ↓
Display logs on page
```

---

## 📁 File Structure (Minimal)

```
autodialer/
├── app/
│   ├── controllers/
│   │   ├── home_controller.rb      # Single controller
│   │   └── webhooks_controller.rb  # Twilio callbacks
│   ├── services/
│   │   ├── ai_prompt_service.rb    # Parse AI commands
│   │   └── twilio_call_service.rb   # Make calls
│   ├── jobs/
│   │   └── call_execution_job.rb    # Background job
│   └── views/
│       └── home/
│           └── index.html.erb       # Single page
├── config/
│   └── routes.rb
└── Gemfile
```

---

## 💾 Data Storage (In-Memory)

### **Option 1: Simple Ruby Hash (Recommended for MVP)**
```ruby
# app/services/call_log_service.rb
class CallLogService
  @@logs = []  # Class variable (in-memory)
  
  def self.add(call_data)
    @@logs << call_data
    @@logs.last(100)  # Keep last 100 calls
  end
  
  def self.all
    @@logs
  end
  
  def self.stats
    {
      total: @@logs.count,
      completed: @@logs.count { |l| l[:status] == 'completed' },
      failed: @@logs.count { |l| l[:status] == 'failed' }
    }
  end
end
```

### **Option 2: JSON File (Simple Persistence)**
```ruby
# Save to log/calls.json
# Load on startup, append on new calls
```

---

## 🛠️ Technology Stack (Minimal)

### **Backend**:
- **Rails 7.x** (API mode or minimal)
- **ActiveJob** with `:async` adapter (no Redis)
- **No database** (in-memory storage)

### **APIs**:
- **Twilio** (calling)
- **OpenAI API** (command parsing)

### **Frontend**:
- **Simple HTML/CSS** (or minimal Bootstrap)
- **Vanilla JavaScript** (or Stimulus for interactivity)

### **Gems Needed**:
```ruby
gem 'rails'
gem 'twilio-ruby'      # Twilio SDK
gem 'httparty'         # OpenAI API calls (or use 'ruby-openai')
gem 'dotenv-rails'     # Environment variables
```

---

## 📋 Implementation Steps (Fast Track)

### **Step 1: Setup (5 min)**
1. `rails new autodialer --minimal`
2. Add gems: `twilio-ruby`, `httparty`, `dotenv-rails`
3. Configure ActiveJob to use `:async` adapter
4. Set up `.env` file for API keys

### **Step 2: Core Services (15 min)**
1. Create `AIPromptService` - Parse "Call to xxxxxx"
2. Create `TwilioCallService` - Make Twilio calls
3. Create `CallLogService` - In-memory storage

### **Step 3: Controllers & Routes (10 min)**
1. `HomeController#index` - Main page
2. `HomeController#ai_prompt` - Handle AI commands
3. `HomeController#upload_numbers` - Handle bulk upload
4. `WebhooksController#status` - Twilio callbacks

### **Step 4: Background Job (5 min)**
1. `CallExecutionJob` - Execute calls asynchronously

### **Step 5: UI (15 min)**
1. Single page with:
   - AI prompt input
   - Phone number textarea (copy/paste)
   - Call logs table
   - Simple stats

### **Step 6: Twilio Integration (10 min)**
1. TwiML endpoint for call flow
2. Webhook endpoint for status updates
3. Test with 1800 numbers

### **Step 7: AI Voice (10 min)**
1. Use Twilio's built-in TTS (`<Say>` in TwiML)
2. Or simple pre-recorded message

---

## 🎨 UI Layout (Single Page)

```
┌─────────────────────────────────────────┐
│  Autodialer MVP                         │
├─────────────────────────────────────────┤
│                                         │
│  [AI Prompt Interface]                  │
│  ┌─────────────────────────────────┐   │
│  │ Type: "Call to +91 9876543210"  │   │
│  └─────────────────────────────────┘   │
│  [Submit]                               │
│                                         │
│  [Bulk Upload]                          │
│  ┌─────────────────────────────────┐   │
│  │ Paste 100 numbers here...       │   │
│  │ +91 9876543210                  │   │
│  │ +91 9876543211                  │   │
│  │ ...                              │   │
│  └─────────────────────────────────┘   │
│  [Upload & Call]                        │
│                                         │
│  [Statistics]                           │
│  Total: 100 | Completed: 45 | Failed: 5 │
│                                         │
│  [Call Logs]                            │
│  ┌─────────────────────────────────┐   │
│  │ Phone        | Status  | Time   │   │
│  │ +91 9876543210| Success | 2:30pm│   │
│  │ +91 9876543211| Failed  | 2:31pm│   │
│  └─────────────────────────────────┘   │
└─────────────────────────────────────────┘
```

---

## 🔧 Configuration

### **config/application.rb**
```ruby
config.active_job.queue_adapter = :async  # No Redis needed!
```

### **.env** (Environment Variables)
```
TWILIO_ACCOUNT_SID=your_account_sid
TWILIO_AUTH_TOKEN=your_auth_token
TWILIO_PHONE_NUMBER=+1234567890
OPENAI_API_KEY=your_openai_key
```

---

## 📝 Code Structure (Minimal)

### **1. AI Prompt Service**
```ruby
# app/services/ai_prompt_service.rb
class AIPromptService
  def self.parse(command)
    # Simple regex or OpenAI API call
    # Returns: { action: 'call', phone: '+919876543210' }
  end
end
```

### **2. Twilio Call Service**
```ruby
# app/services/twilio_call_service.rb
class TwilioCallService
  def self.call(phone_number)
    # Use Twilio SDK to make call
    # Returns: call_sid
  end
end
```

### **3. Call Log Service**
```ruby
# app/services/call_log_service.rb
class CallLogService
  @@logs = []
  
  def self.add(phone, status, call_sid)
    @@logs << {
      phone: phone,
      status: status,
      call_sid: call_sid,
      timestamp: Time.now
    }
  end
  
  def self.all
    @@logs
  end
end
```

### **4. Background Job**
```ruby
# app/jobs/call_execution_job.rb
class CallExecutionJob < ApplicationJob
  queue_as :default
  
  def perform(phone_number)
    call_sid = TwilioCallService.call(phone_number)
    CallLogService.add(phone_number, 'initiated', call_sid)
  end
end
```

### **5. Controller**
```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @logs = CallLogService.all
    @stats = CallLogService.stats
  end
  
  def ai_prompt
    result = AIPromptService.parse(params[:command])
    CallExecutionJob.perform_later(result[:phone])
    redirect_to root_path
  end
  
  def upload_numbers
    numbers = params[:numbers].split("\n").map(&:strip)
    numbers.each { |num| CallExecutionJob.perform_later(num) }
    redirect_to root_path
  end
end
```

---

## 🚀 Quick Start Commands

```bash
# 1. Create Rails app
rails new autodialer --minimal

# 2. Add gems
bundle add twilio-ruby httparty dotenv-rails

# 3. Configure ActiveJob
# config/application.rb: config.active_job.queue_adapter = :async

# 4. Create services, controllers, views
# (We'll do this together)

# 5. Run server
rails server
```

---

## ✅ MVP Features Checklist

- [x] AI prompt interface ("Call to xxxxxx")
- [x] Bulk phone number upload (copy/paste)
- [x] Twilio integration (make calls)
- [x] In-memory call logs
- [x] Simple statistics (total, completed, failed)
- [x] Twilio webhooks (status updates)
- [x] AI voice (Twilio TTS)
- [x] Test with 1800 numbers

---

## 🎯 What We're NOT Building (MVP)

- ❌ Database (using in-memory storage)
- ❌ Redis (using ActiveJob async)
- ❌ Complex UI (single page)
- ❌ User authentication
- ❌ Scheduled calls
- ❌ Call recording
- ❌ Advanced analytics
- ❌ Export functionality

---

## ⚡ Estimated Time: 1-2 hours

This minimal MVP can be built in 1-2 hours and solves the core problem!

---

Ready to start building? Let's create the minimal MVP now! 🚀



