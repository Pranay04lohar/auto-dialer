# Autodialer MVP - 2.5 Minute Video Script

## 📹 Video Outline (2 Minutes 30 Seconds)

### **Introduction (0:00 - 0:15)**

- **What it is**: "This is Autodialer - a Ruby on Rails MVP that automatically dials phone numbers using AI commands and Twilio API"
- **Key features**:
  - AI-powered command interface
  - Bulk phone number calling
  - Real-time call logs and statistics
  - No database needed - minimal MVP

---

### **Demo 1: AI Prompt Interface (0:15 - 0:45)**

**What to show:**

1. Point to the AI Prompt Interface section
2. Type: `Call to +15005550006`
3. Click "Make Call" button
4. Show the call appearing in logs with "Initiated" status
5. Wait 3 seconds - show status updating to "Completed"

**What to say:**

- "You can simply type a command like 'Call to' followed by a phone number"
- "The AI extracts the phone number and automatically initiates the call"
- "Watch as the status updates in real-time from 'Initiated' to 'Completed'"

---

### **Demo 2: Bulk Upload (0:45 - 1:15)**

**What to show:**

1. Navigate to Bulk Upload section
2. Paste multiple test numbers (show the textarea with numbers)
3. Click "Upload & Call All"
4. Show multiple calls being initiated
5. Show statistics updating (Total, Completed, Failed, Success Rate)

**What to say:**

- "For bulk operations, you can paste up to 100 phone numbers"
- "The system processes them automatically with rate limiting"
- "You can see real-time statistics showing total calls, completed, failed, and success rate"

---

### **Demo 3: Call Logs & Statistics (1:15 - 1:40)**

**What to show:**

1. Scroll to Call Logs table
2. Point out different statuses (Completed, Failed, Busy, No Answer)
3. Show statistics cards (Total, Completed, Answered, Failed, Success Rate)
4. Click "Clear Logs" button (show confirmation dialog)

**What to say:**

- "All calls are logged with detailed information - phone number, status, duration, and call SID"
- "The dashboard shows comprehensive statistics"
- "You can clear logs anytime with a single click"

---

### **Demo 4: How the Code Works (1:40 - 2:10)**

**What to show:**

1. Switch to code editor/IDE (or show file structure)
2. Show key files:
   - `app/services/ai_prompt_service.rb` - Highlight phone number extraction
   - `app/services/twilio_call_service.rb` - Show Twilio API call
   - `app/jobs/call_execution_job.rb` - Show background job
   - `app/services/call_log_service.rb` - Show in-memory storage
3. Point out the flow: User → Controller → Service → Job → Twilio
4. Show the simple architecture (no database, in-memory storage)

**What to say:**

- "Let me show you how this works under the hood"
- "When you type 'Call to', the AI Prompt Service extracts the phone number using regex"
- "The Controller enqueues a background job that calls Twilio API"
- "Twilio makes the actual call and sends webhooks back to update the status"
- "All logs are stored in-memory - no database needed"
- "Simple, clean architecture - perfect for an MVP"

**Key Code Points:**

1. **AI Prompt Service** - "This service parses your command and extracts the phone number using regex"
2. **Twilio Call Service** - "This makes the actual API call to Twilio to initiate the call"
3. **Background Job** - "Calls are processed asynchronously in the background using ActiveJob"
4. **Call Log Service** - "In-memory storage - simple array that keeps the last 1000 calls"
5. **Webhook Controller** - "Receives status updates from Twilio and updates the logs in real-time"

**Visual Flow to Show:**

```
User types "Call to +15005550006"
    ↓
HomeController#ai_prompt
    ↓
AiPromptService.parse() → extracts phone number
    ↓
CallExecutionJob.perform_later() → enqueues job
    ↓
TwilioCallService.call() → calls Twilio API
    ↓
Twilio makes the call
    ↓
Webhook → WebhooksController#status → updates log
    ↓
UI updates automatically
```

**Files to Show (Quick Glance):**

- `app/services/ai_prompt_service.rb` - Show the `extract_phone_number` method
- `app/services/twilio_call_service.rb` - Show the `client.calls.create` line
- `app/jobs/call_execution_job.rb` - Show the job structure
- `app/services/call_log_service.rb` - Show the `@@logs = []` in-memory storage

---

### **Technical Wrap-up (2:10 - 2:30)**

**What to show:**

- Return to the UI or show the project structure

**What to say:**

- "Built with Ruby on Rails - minimal MVP with no database"
- "Uses Twilio API for actual phone calls"
- "In-memory storage for fast performance"
- "Works with Twilio test numbers for free testing"
- "Perfect for assignments, demos, or rapid prototyping"

---

## 🎬 Key Points to Emphasize

### **1. Simplicity**

- "No complex setup - just works"
- "Minimal MVP - no database, no Redis"
- "Fast implementation"

### **2. AI Integration**

- "Natural language commands"
- "Just type 'Call to' and a number"
- "AI extracts and processes automatically"

### **3. Real-time Updates**

- "Live status updates"
- "Real-time statistics"
- "Instant feedback"

### **4. Bulk Operations**

- "Handle 100 numbers at once"
- "Automatic rate limiting"
- "Efficient processing"

---

## 📝 Suggested Talking Points

### **Opening (15 seconds)**

> "Hi! I'm going to show you Autodialer - a minimal Ruby on Rails MVP that automatically dials phone numbers using AI commands and Twilio. It's perfect for assignments, demos, or rapid prototyping."

### **AI Prompt Demo (30 seconds)**

> "First, let's try the AI prompt interface. I'll type 'Call to' followed by a phone number. The AI automatically extracts the number and initiates the call. Watch as the status updates in real-time from 'Initiated' to 'Completed'."

### **Bulk Upload Demo (30 seconds)**

> "For bulk operations, I can paste multiple phone numbers and call them all at once. The system processes them automatically with rate limiting. You can see the statistics updating in real-time - total calls, completed, failed, and success rate."

### **Logs & Stats (25 seconds)**

> "All calls are logged with detailed information. The dashboard shows comprehensive statistics. You can clear logs anytime with a single click."

### **Code Explanation (30 seconds)**

> "Let me show you how this works. When you type 'Call to', the AI Prompt Service extracts the phone number. The Controller enqueues a background job that calls Twilio API. Twilio makes the call and sends webhooks back. All logs are stored in-memory - no database needed. Simple, clean architecture."

### **Technical Wrap-up (20 seconds)**

> "This is built with Ruby on Rails as a minimal MVP - no database needed. It uses Twilio API for actual calls and works with test numbers for free testing. Perfect for fast implementation and demos."

---

## 🎯 What to Highlight Visually        

1. **Clean UI** - Show the modern, gradient design
2. **Real-time Updates** - Show status changing live
3. **Statistics Dashboard** - Show the colorful stat cards
4. **Call Logs Table** - Show organized data with status badges
5. **Bulk Upload** - Show pasting multiple numbers
6. **Clear Logs Button** - Show the red button and confirmation
7. **Code Structure** - Show file tree and key services
8. **Flow Diagram** - Show User → Controller → Service → Job → Twilio

---

## ⚠️ Things to Avoid

- Don't show actual phone numbers (use test numbers)
- Don't go into Twilio setup (focus on functionality)
- Don't show errors or debugging
- Don't read code line-by-line (show structure and flow)
- Don't explain every file (focus on key services)

---

## 🎬 Recording Tips

1. **Screen Recording**: Use OBS, Loom, or QuickTime
2. **Resolution**: 1920x1080 recommended
3. **Speed**: Keep it smooth, don't rush
4. **Audio**: Clear voice, minimal background noise
5. **Transitions**: Smooth transitions between sections
6. **Zoom**: Zoom in on important UI elements

---

## 📋 Checklist Before Recording

- [ ] Server is running (`bundle exec rackup -p 3000`)
- [ ] ngrok is running (if needed for webhooks)
- [ ] Test numbers ready to paste
- [ ] Browser window is clean and focused
- [ ] Audio is clear
- [ ] Screen is at good resolution
- [ ] Demo data is ready (some calls already logged)
- [ ] Code editor ready with key files open
- [ ] File structure visible (app/services, app/jobs, app/controllers)

---

## 🎥 Sample Script (Word-for-Word)

**0:00 - 0:15 (Introduction)**

> "Hi! This is Autodialer - a Ruby on Rails MVP that automatically dials phone numbers using AI commands and Twilio API. It's a minimal implementation perfect for assignments and demos."

**0:15 - 0:45 (AI Prompt)**

> "Let's start with the AI prompt interface. I'll type 'Call to' followed by a phone number. The AI automatically extracts the number and initiates the call. Watch as the status updates from 'Initiated' to 'Completed' in real-time."

**0:45 - 1:15 (Bulk Upload)**

> "For bulk operations, I can paste multiple phone numbers here and call them all at once. The system processes them automatically. Notice how the statistics update - total calls, completed, failed, and success rate."

**1:15 - 1:40 (Logs & Stats)**

> "All calls are logged with detailed information. The dashboard shows comprehensive statistics. You can clear logs anytime with this button."

**1:40 - 2:10 (Code Explanation)**

> "Let me show you how this works. When you type 'Call to', the AI Prompt Service extracts the phone number using regex. The Controller enqueues a background job that calls Twilio API. Twilio makes the actual call and sends webhooks back to update the status. All logs are stored in-memory - no database needed. Simple, clean architecture."

**2:10 - 2:30 (Wrap-up)**

> "This is built with Ruby on Rails as a minimal MVP - no database needed. It uses Twilio API and works with test numbers for free testing. Perfect for fast implementation and demos. Thanks for watching!"

---

## 📊 Timing Breakdown

| Section           | Time      | Content                   |
| ----------------- | --------- | ------------------------- |
| Introduction      | 0:00-0:15 | What it is, key features  |
| AI Prompt Demo    | 0:15-0:45 | Type command, show call   |
| Bulk Upload Demo  | 0:45-1:15 | Paste numbers, show stats |
| Logs & Stats      | 1:15-1:40 | Show table, clear button  |
| Code Explanation  | 1:40-2:10 | How the code works        |
| Technical Wrap-up | 2:10-2:30 | Tech stack, use cases     |

---

**Total: 2 minutes 30 seconds!** 🎬
