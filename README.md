# Running Dashboard for E-ink Display

A simple dashboard that displays running statistics on an e-ink display connected to a Raspberry Pi.

## Current Features

- HTML dashboard displaying running stats
- Reads data from JSON file
- Generates PNG image using Puppeteer (headless Chrome)
- Optimized for e-ink displays (800x480px, high contrast)

## Setup

1. Install dependencies:
```bash
npm install
```

2. Generate the dashboard image:
```bash
npm run generate
```

This will create `dashboard.png` in the project directory.

## Project Structure

- `dashboard.html` - Main HTML dashboard
- `data.json` - Running statistics data
- `generate.js` - Script to generate PNG from HTML
- `PLAN.md` - Full implementation plan

## Next Steps

See `PLAN.md` for the full implementation plan including:
- API integration (Strava, Google Calendar)
- E-ink display driver
- Automated daily updates
- OAuth token management

## Customization

- Adjust display dimensions in `generate.js` (CONFIG object)
- Modify dashboard layout in `dashboard.html`
- Update mock data in `data.json`
