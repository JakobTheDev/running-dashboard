#!/usr/bin/env python3
"""
Display script for Waveshare e-ink display
Converts PNG to BMP and renders to e-ink screen
"""

import sys
import os
from PIL import Image

# Import the appropriate Waveshare EPD library for your display
# Change this import based on your specific display model
# Common models: epd7in5_V2, epd5in83, epd4in2, etc.
# Example: from waveshare_epd import epd7in5_V2
try:
    from waveshare_epd import epd7in3e as epd
    DISPLAY_MODEL = "7.3inch E-Ink Display"
except ImportError:
    print("Error: waveshare_epd library not found")
    print("Install with: pip install waveshare-epd")
    sys.exit(1)

# Configuration
CONFIG = {
    'input_png': 'dashboard.png',
    'output_bmp': 'dashboard.bmp',
    'display_width': 800,
    'display_height': 480
}


def convert_png_to_bmp(png_path, bmp_path, width, height):
    """
    Convert PNG image to BMP format optimized for e-ink display
    """
    print(f"Converting {png_path} to BMP format...")

    if not os.path.exists(png_path):
        print(f"Error: Input file '{png_path}' not found")
        sys.exit(1)

    try:
        # Open the PNG image
        img = Image.open(png_path)

        # Resize if dimensions don't match
        if img.size != (width, height):
            print(f"Resizing image from {img.size} to {width}x{height}")
            img = img.resize((width, height), Image.LANCZOS)

        # Convert to RGB mode (BMP format)
        if img.mode != 'RGB':
            print(f"Converting from {img.mode} to RGB mode")
            img = img.convert('RGB')

        # Save as BMP
        img.save(bmp_path, 'BMP')
        print(f"✓ BMP file saved: {bmp_path}")

        return img

    except Exception as e:
        print(f"Error converting image: {e}")
        sys.exit(1)


def display_image(image):
    """
    Display image on Waveshare e-ink display
    """
    print(f"\nInitializing {DISPLAY_MODEL} e-ink display...")

    try:
        # Initialize the display
        display = epd.EPD()
        print("Initializing display...")
        display.init()

        # Clear the display
        print("Clearing display...")
        display.Clear()

        # Display the image
        print("Rendering image to display...")
        display.display(display.getbuffer(image))

        # Put display to sleep to reduce power consumption
        print("Putting display to sleep...")
        display.sleep()

        print("✓ Image successfully displayed!")

    except IOError as e:
        print(f"Error communicating with display: {e}")
        print("Make sure:")
        print("  1. SPI is enabled on your Raspberry Pi")
        print("  2. Display is properly connected")
        print("  3. You're running with appropriate permissions (try sudo)")
        sys.exit(1)
    except Exception as e:
        print(f"Error displaying image: {e}")
        sys.exit(1)


def main():
    """
    Main function to convert and display image
    """
    print("=" * 60)
    print("Waveshare E-ink Display - Running Dashboard")
    print("=" * 60)

    # Convert PNG to BMP
    image = convert_png_to_bmp(
        CONFIG['input_png'],
        CONFIG['output_bmp'],
        CONFIG['display_width'],
        CONFIG['display_height']
    )

    # Display on e-ink screen
    display_image(image)

    print("\n" + "=" * 60)
    print("Display update complete!")
    print("=" * 60)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nInterrupted by user")
        sys.exit(0)
