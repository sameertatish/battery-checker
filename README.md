# Battery Monitor Flutter App

## Overview

This Flutter app monitors battery status and responds to charger connect/disconnect events.  
It uses **native Android code (Kotlin)** via **Flutter Platform Channels** to get detailed battery information and play sounds when the charger is connected or disconnected.

---

## Features

- Get detailed battery information:
  - Battery percentage
  - Charging status (charging, discharging, full, etc.)
  - Battery health (good, cold, overheat, dead, etc.)
  - Plugged type (AC, USB, wireless)
  - Temperature (°C)
  - Voltage (mV)
  - Battery technology (e.g., Li-ion)

- Detect charger connect/disconnect in real-time
- Play custom sounds for connect/disconnect events
- Map raw battery values to human-readable strings in Flutter UI
- Full integration using **Flutter + Kotlin native code**


## How It Works

1. **Flutter Side**
   - Uses `MethodChannel` to call native Android methods.
   - Invokes `getBatteryInfo` to retrieve detailed battery data.
   - Listens for charger connect/disconnect events from native code.
   - Displays battery info and status messages in the UI.

2. **Native Android (Kotlin) Side**
   - Uses `BatteryManager` and `ACTION_BATTERY_CHANGED` to fetch battery details.
   - Uses `BroadcastReceiver` to listen for `ACTION_POWER_CONNECTED` and `ACTION_POWER_DISCONNECTED`.
   - Plays custom audio files for connect/disconnect events.
   - Sends battery events to Flutter via the platform channel.
   - Maps Android battery constants (health, status, plugged type) to human-readable strings.  
     For reference, see the official Android documentation: [BatteryManager | Android Developers](https://developer.android.com/reference/android/os/BatteryManager)
