# coffee

A replacement for [caffeine](https://www.caffeine-app.net/) MacOS app

## Build
From the root of the repo:
```bash
xcrun swiftc -o Coffee.app/Contents/MacOS/Coffee main.swift -framework Cocoa
open Coffee.app
```

## Install
From the root of the repo:
```bash
osascript -e 'tell application "System Events" to make login item at end with properties {name:"Coffee", path:"/path/to/Coffee.app", hidden:false}'
```