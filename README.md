# Running Dashboard for E-ink Display

A simple dashboard that displays running statistics on an e-ink display connected to a Raspberry Pi.

## Current Features

- HTML dashboard displaying running stats
- Reads data from JSON file
- Generates PNG image using Puppeteer (headless Chrome)
- Python script for Waveshare e-ink display rendering
- Optimized for e-ink displays (800x480px, high contrast)

## Setup

### Node.js Setup (Image Generation)

1. Install Node.js dependencies:
```bash
npm install
```

2. Generate the dashboard image:
```bash
npm run generate
```

This will create `dashboard.png` in the project directory.

### Python Setup (Display on E-ink)

1. Install Python dependencies (on Raspberry Pi):
```bash
pip3 install -r requirements.txt
```

2. Configure your display model in `src/scripts/display.py`:
```python
# Change this line to match your Waveshare display model
from waveshare_epd import epd7in5_V2 as epd
```

Common display models:
- `epd7in5_V2` - 7.5inch e-Paper HAT V2 (800x480)
- `epd5in83` - 5.83inch e-Paper HAT (648x480)
- `epd4in2` - 4.2inch e-Paper Module (400x300)

3. Display the dashboard on e-ink (requires sudo on Raspberry Pi):
```bash
sudo python3 src/scripts/display.py
```

## Complete Workflow

On your development machine:
```bash
# Update data and generate image
npm run generate
```

On Raspberry Pi:
```bash
# Transfer files (if needed)
scp dashboard.png pi@raspberrypi:/home/pi/running-dashboard/

# Display on e-ink
cd /home/pi/running-dashboard/
sudo python3 src/scripts/display.py
```

## Project Structure

```
├── src/
│   ├── web/              # Web dashboard files
│   │   ├── dashboard.html
│   │   └── data.json
│   └── scripts/          # Automation scripts
│       ├── display.py
│       ├── update_display.sh
│       └── setup_pi.sh
├── generate.js           # PNG generation script
├── package.json          # Node.js dependencies
├── requirements.txt      # Python dependencies
└── PLAN.md               # Full implementation plan
```

## Raspberry Pi Setup Notes

1. Enable SPI interface:
```bash
sudo raspi-config
# Navigate to: Interfacing Options > SPI > Enable
```

2. Install system dependencies:
```bash
sudo apt-get update
sudo apt-get install python3-pip python3-pil python3-numpy
```

## Next Steps

See `PLAN.md` for the full implementation plan including:
- API integration (Strava, Google Calendar)
- Automated daily updates with cron
- OAuth token management

## Customization

- Adjust display dimensions in `generate.js` (CONFIG object)
- Modify dashboard layout in `src/web/dashboard.html`
- Update mock data in `src/web/data.json`
- Configure display model in `src/scripts/display.py`
