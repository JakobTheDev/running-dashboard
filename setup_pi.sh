#!/bin/bash
# Setup script for Raspberry Pi e-ink display

echo "================================"
echo "Raspberry Pi E-ink Setup"
echo "================================"
echo ""

# Check if running on Raspberry Pi
if ! command -v raspi-config &> /dev/null; then
    echo "Warning: This doesn't appear to be a Raspberry Pi"
    echo "This script is intended for Raspberry Pi only"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "[1/4] Updating system packages..."
sudo apt-get update

echo ""
echo "[2/4] Installing system dependencies..."
sudo apt-get install -y python3-pip python3-pil python3-numpy python3-dev

echo ""
echo "[3/4] Installing Python packages..."
pip3 install -r requirements.txt

echo ""
echo "[4/4] Checking SPI status..."
if lsmod | grep -q spi_bcm2835; then
    echo "✓ SPI is enabled"
else
    echo "⚠ SPI is not enabled!"
    echo "Enable it with: sudo raspi-config"
    echo "Navigate to: Interfacing Options > SPI > Enable"
    echo "Then reboot your Pi"
fi

echo ""
echo "================================"
echo "Setup complete!"
echo "================================"
echo ""
echo "Next steps:"
echo "1. Make sure SPI is enabled (see above)"
echo "2. Update display model in display.py if needed"
echo "3. Run: sudo python3 display.py"
