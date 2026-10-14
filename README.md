# Shape Matching

## Run (Android emulator)

1. List emulators: `flutter emulators`
2. Start one: `flutter emulators --launch Pixel_API_35`
   (or start it from Android Studio: Device Manager > Play)
3. From this folder:

```
flutter pub get
flutter run
```

If multiple devices are open, pick one with `flutter run -d <device_id>` (see `flutter devices`).

## Stop

- Stop the app: press `q` in the terminal running `flutter run` (or `Ctrl+C`).
- Stop the emulator: `adb emu kill` (or close the emulator window).
