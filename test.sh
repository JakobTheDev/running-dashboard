import RPi.GPIO as GPIO
import time

TEST_PIN = 2

def test_callback(channel):
    print(f"SUCCESS: Event detected on pin {channel}!")

try:
    GPIO.setmode(GPIO.BCM)
    GPIO.setwarnings(True) # See if any warnings appear before the error

    print(f"Attempting to set up pin {TEST_PIN} as INPUT PULL_UP.")
    GPIO.setup(TEST_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    print(f"Pin {TEST_PIN} setup complete.")

    time.sleep(0.1) # wait

    print(f"Attempting to add event detection to pin {TEST_PIN}.")
    GPIO.add_event_detect(TEST_PIN, GPIO.FALLING, callback=test_callback, bouncetime=200)
    print(f"Event detection added successfully to pin {TEST_PIN}.")

    while True:
        time.sleep(1)

except RuntimeError as e:
    print(f"ERROR during GPIO operation on pin {TEST_PIN}: {e}")
except Exception as e:
    print(f"An unexpected error occurred: {e}")
finally:
    print("Cleaning up GPIO...")
    GPIO.cleanup()