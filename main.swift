import Cocoa
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var timer: Timer?
    var isCoffeeEnabled = false

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "bolt.fill", accessibilityDescription: "Coffee")
        }
        constructMenu()
    }

    func constructMenu() {
        let menu = NSMenu()
        let toggleItem = NSMenuItem(title: "Enable Coffee", action: #selector(toggleCoffee), keyEquivalent: "")
        toggleItem.target = self
        menu.addItem(toggleItem)
        menu.addItem(NSMenuItem.separator())
        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)
        statusItem.menu = menu
    }

    @objc func toggleCoffee() {
        isCoffeeEnabled.toggle()
        if isCoffeeEnabled {
            startTimer()
            updateMenuTitle("Disable Coffee")
        } else {
            stopTimer()
            updateMenuTitle("Enable Coffee")
        }
    }

    func updateMenuTitle(_ title: String) {
        if let menu = statusItem.menu, let firstItem = menu.item(at: 0) {
            firstItem.title = title
        }
    }

    func startTimer() {
        // Simulate key press every 30 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.simulateKeyPress()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func simulateKeyPress() {
        // F13 (key code 105) is rarely used, so it's a safe candidate for a "phantom" key press.
        let keyCode: CGKeyCode = 105
        guard let keyDown = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: true),
              let keyUp = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: false)
        else { return }
        keyDown.post(tap: .cghidEventTap)
        keyUp.post(tap: .cghidEventTap)
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(self)
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
