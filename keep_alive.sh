#!/bin/bash

# Website to keep alive
url="https://hans-blogs.onrender.com/home"
output_file="keep_alive.log"

# green if successful , red if fails
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Curl to check the website
status_code=$(curl --insecure -s -o /dev/null -w "%{http_code}" "$url")

# recevies 200 if successful
if [[ "$status_code" == "200" ]]; then
    echo -e "${timestamp} - ${GREEN}SUCCESS${NC} - $url responded with status 200" | tee -a "$output_file"
else
    echo -e "${timestamp} - ${RED}FAIL${NC} - $url responded with status $status_code" | tee -a "$output_file"
fi
