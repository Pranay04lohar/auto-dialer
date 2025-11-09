# Windows Setup Guide

## Do You Need MSYS2?

### ✅ **YES - If using Puma (Recommended)**
- **Puma** (web server) requires native C extensions
- You **MUST** install MSYS2 to compile Puma
- Better performance and production-ready

### ❌ **NO - If using WEBrick (Alternative)**
- **WEBrick** is pure Ruby, no native extensions
- Works without MSYS2
- Slower, but fine for development/testing

---

## Option 1: Install MSYS2 (Recommended) ⭐

### Steps:

1. **Install RubyInstaller**
   - Download: https://rubyinstaller.org/
   - Choose: **Ruby+Devkit** version (includes MSYS2)
   - Or install Ruby first, then run `ridk install`

2. **Run MSYS2 Setup**
   ```bash
   ridk install
   ```
   - Select option **1** (MSYS2 base installation)
   - Select option **2** (MSYS2 and MINGW development toolchain)
   - Select option **3** (MSYS2 and MINGW development toolchain) - if needed

3. **Verify Installation**
   ```bash
   ruby -v
   gem -v
   ```

4. **Install Gems**
   ```bash
   bundle install
   ```

**Result**: Puma will compile successfully! ✅

---

## Option 2: Use WEBrick (No MSYS2 Needed)

### Steps:

1. **Install Ruby** (without Devkit is fine)
   - Download: https://rubyinstaller.org/
   - Choose: **Ruby** (without Devkit)

2. **The Gemfile is already updated** to use WEBrick instead of Puma

3. **Install Gems**
   ```bash
   bundle install
   ```

**Result**: Works without MSYS2, but slower! ⚠️

---

## Comparison

| Feature | Puma (with MSYS2) | WEBrick (no MSYS2) |
|---------|-------------------|---------------------|
| **Setup** | Requires MSYS2 | No setup needed |
| **Performance** | ⚡ Fast | 🐌 Slower |
| **Production** | ✅ Yes | ❌ No |
| **Concurrent Requests** | ✅ Yes | ❌ Limited |
| **For MVP** | ✅ Perfect | ✅ OK for testing |

---

## My Recommendation

### For Your Assignment (MVP):

**Use WEBrick** (Option 2) if:
- ✅ You want to avoid MSYS2 setup
- ✅ Just need to test/demo the app
- ✅ Don't need high performance

**Use Puma** (Option 1) if:
- ✅ You want better performance
- ✅ Might deploy to production
- ✅ Don't mind installing MSYS2

---

## Quick Start (WEBrick - No MSYS2)

1. Install Ruby (without Devkit)
2. Run:
   ```bash
   gem install bundler
   bundle install
   rails server
   ```

That's it! No MSYS2 needed! 🎉

---

## Quick Start (Puma - With MSYS2)

1. Install Ruby+Devkit (includes MSYS2)
2. Run:
   ```bash
   ridk install  # Setup MSYS2
   gem install bundler
   bundle install
   rails server
   ```

---

**The Gemfile is already configured for WEBrick, so you can skip MSYS2 if you want!** 🚀



