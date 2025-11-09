# Quick Setup Instructions

## 🚀 Getting Started

### Step 1: Install Ruby (if not installed)

**Windows:**
- Download RubyInstaller: https://rubyinstaller.org/
- Install Ruby 3.0+ and DevKit

**Mac:**
```bash
brew install ruby
```

**Linux:**
```bash
sudo apt-get install ruby-full
```

### Step 2: Install Bundler

```bash
gem install bundler
```

### Step 3: Install Dependencies

```bash
bundle install
```

### Step 4: Set Up Twilio

1. **Sign up for Twilio Free Trial**
   - Go to: https://www.twilio.com/try-twilio
   - Sign up and verify your account
   - Get **$15 free credit**

2. **Get Your Credentials**
   - Go to Twilio Console: https://console.twilio.com/
   - Copy:
     - **Account SID** (starts with `AC...`)
     - **Auth Token** (click to reveal)
     - **Phone Number** (Twilio will provide one)

3. **Create `.env` File**
   ```bash
   cp .env.example .env
   ```

4. **Add Credentials to `.env`**
   ```
   TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
   TWILIO_AUTH_TOKEN=your_auth_token_here
   TWILIO_PHONE_NUMBER=+1234567890
   BASE_URL=http://localhost:3000
   ```

### Step 5: Set Up Webhooks (for Local Development)

Twilio needs to send webhooks to your local server. Use **ngrok**:

1. **Install ngrok**
   - Download: https://ngrok.com/download
   - Or: `brew install ngrok` (Mac)

2. **Start ngrok**
   ```bash
   ngrok http 3000
   ```

3. **Update `.env`**
   ```
   BASE_URL=https://your-ngrok-url.ngrok.io
   ```

### Step 6: Run the Server

```bash
rails server
```

Visit: **http://localhost:3000**

---

## 🧪 Testing with Test Numbers

### Twilio Test Numbers (FREE!)

Use these test numbers for free testing:

```
+15005550006  - Always answers ✅
+15005550001  - Always busy ❌
+15005550002  - Always no answer ❌
+15005550003  - Always fails ❌
+15005550004  - Invalid number ❌
+15005550005  - Unreachable ❌
```

### Generate 100 Test Numbers

You can create a list like this:

```
+15005550006
+15005550001
+15005550006
+15005550002
+15005550006
+15005550003
... (repeat to get 100)
```

Or use the `TestNumberGenerator` service in the code!

---

## 📝 Usage

### AI Prompt Interface

Type commands like:
- "Call to +15005550006"
- "Make a call to 1800-555-0006"
- "Call +91 9876543210"

### Bulk Upload

Paste phone numbers (one per line):
```
+15005550006
+15005550001
+15005550002
...
```

---

## ⚠️ Troubleshooting

### "Rails command not found"
- Make sure Ruby is installed
- Run: `gem install rails`
- Or use: `bundle exec rails server`

### "Twilio credentials not configured"
- Check your `.env` file exists
- Verify credentials are correct
- Restart the server after changing `.env`

### "Webhook not working"
- Make sure ngrok is running
- Update `BASE_URL` in `.env` with ngrok URL
- Check ngrok web interface: http://localhost:4040

### "Call not initiating"
- Check Twilio account has credit
- Verify phone number format (include country code)
- Check server logs for errors

---

## 🎯 Next Steps

1. ✅ Set up Twilio account
2. ✅ Configure `.env` file
3. ✅ Start ngrok for webhooks
4. ✅ Run `rails server`
5. ✅ Test with test numbers!

---

**Ready to go!** 🚀



