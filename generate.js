const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');
const http = require('http');

// Configuration
const CONFIG = {
  // E-ink display dimensions - adjust for your specific display
  width: 800,
  height: 480,
  outputPath: path.join(__dirname, 'dashboard.png'),
  htmlPath: path.join(__dirname, 'dashboard.html'),
  port: 8765
};

// Simple HTTP server to serve local files
function startServer() {
  const server = http.createServer((req, res) => {
    let filePath = path.join(__dirname, req.url === '/' ? 'dashboard.html' : req.url);

    const ext = path.extname(filePath);
    const contentType = {
      '.html': 'text/html',
      '.json': 'application/json',
      '.css': 'text/css',
      '.js': 'text/javascript'
    }[ext] || 'text/plain';

    fs.readFile(filePath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end('File not found');
        return;
      }
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(data);
    });
  });

  server.listen(CONFIG.port);
  return server;
}

async function generateDashboard() {
  console.log('Starting dashboard generation...');

  // Check if HTML file exists
  if (!fs.existsSync(CONFIG.htmlPath)) {
    console.error(`Error: HTML file not found at ${CONFIG.htmlPath}`);
    process.exit(1);
  }

  let browser;
  let server;

  try {
    // Start local HTTP server
    console.log(`Starting local server on port ${CONFIG.port}...`);
    server = startServer();

    // Launch headless browser
    console.log('Launching browser...');
    browser = await puppeteer.launch({
      headless: 'new',
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-accelerated-2d-canvas',
        '--disable-gpu'
      ]
    });

    const page = await browser.newPage();

    // Set viewport to match e-ink display dimensions
    await page.setViewport({
      width: CONFIG.width,
      height: CONFIG.height,
      deviceScaleFactor: 1
    });

    // Load the HTML via local server
    const url = `http://localhost:${CONFIG.port}/`;
    console.log(`Loading ${url}...`);
    await page.goto(url, {
      waitUntil: 'networkidle0' // Wait for all resources to load
    });

    // Wait a bit for any JavaScript to execute
    await new Promise(resolve => setTimeout(resolve, 1000));

    // Take screenshot
    console.log(`Generating screenshot at ${CONFIG.width}x${CONFIG.height}...`);
    await page.screenshot({
      path: CONFIG.outputPath,
      type: 'png',
      clip: {
        x: 0,
        y: 0,
        width: CONFIG.width,
        height: CONFIG.height
      }
    });

    console.log(`✓ Dashboard image generated successfully: ${CONFIG.outputPath}`);

  } catch (error) {
    console.error('Error generating dashboard:', error);
    process.exit(1);
  } finally {
    if (browser) {
      await browser.close();
    }
    if (server) {
      server.close();
    }
  }
}

// Run the generator
generateDashboard();
