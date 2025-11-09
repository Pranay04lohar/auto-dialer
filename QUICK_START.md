# 🚀 Quick Start Guide

## Prerequisites

- Ruby 2.7+ installed
- Twilio free trial account ($15 credit)

## Setup (5 minutes)

### 1. Install Dependencies
```bash
bundle install
```

### 2. Configure Twilio

1. Sign up: https://www.twilio.com/try-twilio
2. Get credentials from Twilio Console
3. Create `.env` file:
   ```bash
   cp .env.example .env
   ```
4. Add your Twilio credentials to `.env`

### 3. Start ngrok (for webhooks)
```bash
ngrok http 3000
```
Copy the ngrok URL and update `BASE_URL` in `.env`

### 4. Run Server
```bash
rails server
```

Visit: **http://localhost:3000**

---

## 🧪 Test with Free Test Numbers

### Option 1: AI Prompt
Type: `Call to +15005550006`

### Option 2: Bulk Upload
Paste these test numbers:
```
+15005550006
+15005550001
+15005550002
+15005550003
+15005550004
+15005550005
```

### Option 3: Generate 100 Test Numbers
```bash
rails test_numbers:generate
```
Copy the output and paste in bulk upload!

---

## ✅ That's It!

You're ready to test! All test numbers are **FREE** with Twilio trial account.

---

## 📞 Test Numbers Reference

- `+15005550006` - ✅ Always answers
- `+15005550001` - ❌ Always busy
- `+15005550002` - ❌ Always no answer
- `+15005550003` - ❌ Always fails
- `+15005550004` - ❌ Invalid number
- `+15005550005` - ❌ Unreachable

---

**Happy Testing!** 🎉



