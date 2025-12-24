# GotoBed

A macOS menu bar utility that helps you identify processes preventing your Mac from sleeping, so you can finally go to bed.

## How It Works

GotoBed monitors macOS power management assertions using `IOPMCopyAssertionsByProcess`. These assertions are created by applications and system processes to prevent the system from entering idle sleep or allowing restarts.

## Installation

1. Clone or download this repository
2. Open `GotoBed.xcodeproj` in Xcode
3. Build and run the project
4. The app will appear in your menu bar as a moon icon

## Usage

1. Click the moon icon in your menu bar
2. View the list of processes preventing sleep
3. Click on user application names to switch to them
4. Quit or close applications as needed
5. Use the "Quit" button to close GotoBed

## System Requirements

- macOS 12.0 or later
- Xcode 14.0 or later (for building)

## Contributing

Feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
