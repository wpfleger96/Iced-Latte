import Cocoa
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var timer: Timer?
    var isIcedLatteEnabled = false

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "bolt.fill", accessibilityDescription: "Iced Latte")
        }
        constructMenu()

        // Auto enable at app startup
        isIcedLatteEnabled = true
        startTimer()
        updateMenuTitle("Disable Iced Latte")

        // Force the first simulated keypress after app starts instead of waiting for the timer,
        // so that the user is prompted immediately to grant accessibility permissions.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.simulateKeyPress()
        }
    }

    func constructMenu() {
        let menu = NSMenu()
        let toggleItem = NSMenuItem(title: "Enable Iced Latte", action: #selector(toggleIcedLatte), keyEquivalent: "")
        toggleItem.target = self
        menu.addItem(toggleItem)
        menu.addItem(NSMenuItem.separator())
        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)
        statusItem.menu = menu
    }

    @objc func toggleIcedLatte() {
        isIcedLatteEnabled.toggle()
        if isIcedLatteEnabled {
            startTimer()
            updateMenuTitle("Disable Iced Latte")
        } else {
            stopTimer()
            updateMenuTitle("Enable Iced Latte")
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
