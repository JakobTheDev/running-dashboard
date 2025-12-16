#!/bin/bash
# Complete update script: Generate dashboard and display on e-ink

set -e  # Exit on error

echo "================================"
echo "Running Dashboard Update"
echo "================================"
echo ""

# Step 1: Generate dashboard image
echo "[1/2] Generating dashboard image..."
npm run generate

# Step 2: Display on e-ink (only if on Raspberry Pi)
if command -v raspi-config &> /dev/null; then
    echo ""
    echo "[2/2] Displaying on e-ink..."
    sudo python3 display.py
else
    echo ""
    echo "[2/2] Skipping display - not on Raspberry Pi"
    echo "Transfer dashboard.png to your Pi and run: sudo python3 display.py"
fi

echo ""
echo "================================"
echo "Update complete!"
echo "================================"
