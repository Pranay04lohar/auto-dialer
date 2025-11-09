# Autodialer MVP

A minimal Ruby on Rails application for automated phone calling with AI prompt interface.

## Features

- 🤖 **AI Prompt Interface**: Type "Call to xxxxxx" and the system extracts the number
- 📋 **Bulk Upload**: Paste up to 100 phone numbers and call them all
- 📊 **Statistics**: View total calls, completed, failed, and success rate
- 📝 **Call Logs**: See detailed logs of all calls
- 🎤 **AI Voice**: Uses Twilio's text-to-speech for automated messages
- 🆓 **Free Testing**: Works with Twilio free trial using test numbers

## Setup

### 1. Install Dependencies

```bash
bundle install
```

### 2. Configure Twilio

1. Sign up for Twilio free trial: https://www.twilio.com/try-twilio
2. Get your credentials from Twilio Console:
   - Account SID
   - Auth Token
   - Phone Number (Twilio will provide one)

3. Create `.env` file:

```bash
cp .env.example .env
```

4. Add your Twilio credentials to `.env`:

```
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token_here
TWILIO_PHONE_NUMBER=+1234567890
BASE_URL=http://localhost:3000
```

### 3. For Local Development (Webhooks)

Twilio needs to send webhooks to your local server. Use ngrok:

```bash
# Install ngrok: https://ngrok.com/
ngrok http 3000
```

Then update `.env`:
```
BASE_URL=https://your-ngrok-url.ngrok.io
```

### 4. Run the Server

```bash
rails server
```

Visit: http://localhost:3000

## Usage

### AI Prompt Interface

Type commands like:
- "Call to +15005550006"
- "Call to +91 9876543210"
- "Make a call to 1800-555-0006"

### Bulk Upload

Paste phone numbers (one per line):
```
+15005550006
+15005550001
+15005550002
...
```

### Test Numbers (Free with Twilio Trial)

Use Twilio test numbers for free testing:
- `+15005550006` - Always answers ✅
- `+15005550001` - Always busy ❌
- `+15005550002` - Always no answer ❌
- `+15005550003` - Always fails ❌
- `+15005550004` - Invalid number ❌
- `+15005550005` - Unreachable ❌

## Architecture

- **No Database**: Uses in-memory storage (resets on restart)
- **No Redis**: Uses ActiveJob with `:async` adapter
- **Minimal Setup**: Single page, simple structure

## File Structure

```
app/
├── controllers/
│   ├── home_controller.rb      # Main controller
│   └── webhooks_controller.rb  # Twilio callbacks
├── services/
│   ├── ai_prompt_service.rb    # Parse AI commands
│   ├── twilio_call_service.rb  # Make calls
│   ├── call_log_service.rb    # In-memory logs
│   └── test_number_generator.rb # Generate test numbers
├── jobs/
│   └── call_execution_job.rb   # Background job
└── views/
    └── home/
        └── index.html.erb      # Single page UI
```

## Cost

- **Free Trial**: Works with Twilio free trial ($15 credit)
- **Test Numbers**: FREE to call (no cost)
- **Real Numbers**: ~$0.013 per minute (~$1.30 for 100 calls)

## License

MIT



