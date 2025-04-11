# 🔄 Render Keep-Alive Script

This repository contains a simple Bash script that pings a Render-hosted website at regular intervals to prevent it from going to sleep due to inactivity (a common limitation of Render's free tier).

---

## 📌 Problem

Render's free tier puts web services to sleep when there's no traffic for a certain period. This leads to:

- ❄️ Cold starts (30–60 seconds)
- 🧍 Poor user experience for first-time visitors
- 🚫 Uptime monitoring failures

---

## ⚙️ Solution

This script sends a `curl` request every 2 minutes to your site and logs the response status — helping keep your site active and reducing cold starts.

---

## 🛠️ Tech Used

- **Bash** (tested on Git Bash for Windows)
- **curl**
- **Windows Task Scheduler** (to automate the script execution)

---

## 📄 Script Overview

```bash
#!/bin/bash

# Website to keep alive
url="https://hans-blogs.onrender.com/home"
output_file="keep_alive.log"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Curl request
status_code=$(curl --insecure -s -o /dev/null -w "%{http_code}" "$url")

# Log result
if [[ "$status_code" == "200" ]]; then
    echo -e "${timestamp} - ${GREEN}SUCCESS${NC} - $url responded with status 200" | tee -a "$output_file"
else
    echo -e "${timestamp} - ${RED}FAIL${NC} - $url responded with status $status_code" | tee -a "$output_file"
fi
```

---

## 📆 Setup Instructions (Windows Task Scheduler)

1. **Save Script**  
   Save the script as `keep_alive.sh` on your desktop or another accessible path.

2. **Make it Executable**  
   Open Git Bash and run:
   ```bash
   chmod +x keep_alive.sh
   ```

3. **Open Task Scheduler**  
   - Create a new task: `Keep Render Site Awake`
   - Run whether user is logged in or not
   - Use highest privileges

4. **Add Action**  
   - Program: `C:\Program Files\Git\bin\bash.exe`  
   - Argument:  
     ```sh
     -c "/c/Users/<YourUser>/Desktop/keep_alive.sh"
     ```

5. **Add Trigger**  
   - Start daily
   - Repeat every 2 minutes for 1 day (set it to recur)

6. **Enable Task History**  
   - Monitor output via `keep_alive.log`

---

## 🧪 Sample Output

```
2025-04-10 12:02:12 - SUCCESS - https://hans-blogs.onrender.com/home responded with status 200
2025-04-10 12:04:12 - SUCCESS - https://hans-blogs.onrender.com/home responded with status 200
```

---

## 🧠 Final Thoughts

This script is lightweight but powerful when paired with automation. If you're on Render’s free plan and want better responsiveness, this solution is for you.

You can also run it on a Linux cloud server or schedule it using `cron` if you prefer a cross-platform or cloud-native option.

---

## 🙋‍♂️ Author

**Hans Kang**  
🔗 [Portfolio](https://hanskang.com) | [Blog](https://hans-blog-new-repo.onrender.com) | [LinkedIn](https://linkedin.com/in/hanskkang)
