# Running Dashboard - E-ink Display

## Project Goal
Display running stats on a Raspberry Pi connected to an e-ink display. Daily automated updates showing Strava data and Google Calendar events.

## Stack

**Frontend:**
- HTML/CSS (starting simple, can upgrade to React later)
- Reads from static JSON file

**Backend/Automation:**
- Node.js script for orchestration
- Puppeteer (headless Chrome) to render HTML to PNG/image
- Node-cron or system cron for scheduling

**Display Driver:**
- Python script for e-ink display control
- Communication via file system (Node generates image, Python displays it)

**APIs (Future):**
- Strava API (OAuth 2.0)
- Google Calendar API (OAuth 2.0)

## Implementation Phases

### Phase 1: Basic HTML Dashboard ✓ (Starting Here)
1. Create HTML page with static layout
2. Load data from JSON file
3. Design for e-ink (high contrast, simple)
4. Components: weekly mileage, recent runs, calendar events, stats

### Phase 2: Image Generation Pipeline ✓ (Starting Here)
1. Set up Puppeteer script
2. Render HTML to PNG at e-ink dimensions
3. Create orchestrator script

### Phase 3: Data Fetching (Future)
1. Set up Strava OAuth flow
2. Set up Google Calendar OAuth
3. Create data fetching script
4. Store tokens securely

### Phase 4: E-ink Integration (Future)
1. Python script for specific e-ink display model
2. Test with generated images
3. Integrate with pipeline

### Phase 5: Automation (Future)
1. Complete orchestrator script
2. Set up cron job on Pi
3. Error handling and logging

## Architecture

```
Daily Cron Job
     ↓
Node.js Orchestrator
     ↓
1. Fetch data (Strava, Google) → data.json
2. Puppeteer renders HTML → dashboard.png
3. Python script displays image
```

## Notes
- E-ink displays typically black & white or limited colors
- Most e-ink libraries are Python-based
- Store OAuth refresh tokens securely
- Consider partial refresh if display supports it
