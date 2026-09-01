#!/bin/bash

# ==========================================
# Simple server health check
# Shows cpu, memory, disk and running services
# ==========================================

echo "======================================="
echo "        SERVER HEALTH CHECK"
echo "        $(date)"
echo "======================================="
echo ""

echo "--- Uptime & Load ---"
uptime
echo ""

echo "--- Memory ---"
free -h
echo ""

echo "--- Disk Space ---"
df -h | grep -v "tmpfs\|loop"
echo ""

echo "--- CPU usage ---"
top -bn1 | head -5
echo ""

echo "--- Top 5 processes using memory ---"
ps aux --sort=-%mem | head -6
echo ""

echo "--- Listening ports (note: needs root for process names) ---"
ss -tlnp 2>/dev/null | head -10
echo ""
echo "======================================="
echo "Health check done!"