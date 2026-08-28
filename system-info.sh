#!/bin/bash

# Simple script to show system information
# I made this while learning bash scripting

echo "======================================="
echo "        SYSTEM INFORMATION"
echo "======================================="
echo ""
echo "Generated on: $(date)"
echo ""

echo "--- Operating System ---"
cat /etc/os-release | grep -E "^(NAME|VERSION)="
echo ""

echo "--- Kernel version ---"
uname -r
echo ""

echo "--- Hostname ---"
hostname
echo ""

echo "--- CPU ---"
echo "Number of cores: $(nproc)"
echo ""

echo "--- Memory ---"
free -h | grep "Mem:"
echo ""

echo "--- Disk usage ---"
df -h /
echo ""

echo "--- Uptime ---"
uptime
echo ""
echo "======================================="
echo "Done!"
