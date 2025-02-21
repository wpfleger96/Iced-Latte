# Iced-Latte

A replacement for the [caffeine](https://www.caffeine-app.net/) MacOS app

## Requirements
- MacOS Sequoia 15.3 or later
- `xcrun` via XCode commmand line tools:
```sh
xcode-select --install
```

## Setup

### Build
First build the app from source using the following command from the root of the repo:
```sh
xcrun swiftc -o Iced-Latte.app/Contents/MacOS/Iced-Latte main.swift -framework Cocoa
```
Then launch the app:
```sh
open Iced-Latte.app
```
After the app starts you'll be prompted to grant accessibility permissions, once granted the app will continue running according to the timer.

### Install
Use the following command to auto start the app on login, replacing with the appropriate path:
```sh
osascript -e 'tell application "System Events" to make login item at end with properties {name:"Iced-Latte", path:"/path/to/Iced-Latte.app", hidden:false}'
```