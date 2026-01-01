import SwiftUI

@main
struct PasteApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: Constants.windowWidth, minHeight: Constants.windowHeight)
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
    }
}

/// Application Delegate do obsługi globalnych hotkey
class AppDelegate: NSObject, NSApplicationDelegate {
    private let historyManager = HistoryManager.shared
    private let clipboardService = ClipboardService.shared
    private let hotKeyManager = HotKeyManager.shared
    
    private var historyWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Setup clipboard monitoring
        clipboardService.startMonitoring()
        
        clipboardService.onClipboardChange = { [weak self] in
            if let content = self?.clipboardService.getCurrentContent() {
                let item = ClipboardItem(
                    content: content,
                    contentType: self?.clipboardService.getContentType() ?? .text
                )
                self?.historyManager.addItem(item)
            }
        }
        
        // Setup hotkey
        hotKeyManager.registerHotKey { [weak self] in
            self?.toggleHistoryWindow()
        }
        
        // Preload history from storage
        historyManager.loadFromStorage()
        
        // Log startup
        NSLog("Paste aplikacja uruchomiona - wersja \(Constants.appVersion)")
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        clipboardService.stopMonitoring()
        hotKeyManager.unregisterHotKey()
        NSLog("Paste aplikacja zatrzymana")
    }
    
    // MARK: - Window Management
    
    private func toggleHistoryWindow() {
        // Sprawdź czy okno już istnieje i jest widoczne
        if let window = NSApplication.shared.windows.first(where: { $0.title.isEmpty || $0.title == "ContentView" }) {
            if window.isVisible {
                window.close()
                return
            } else {
                window.makeKeyAndOrderFront(nil)
                NSApplication.shared.activate(ignoringOtherApps: true)
                return
            }
        }
        
        // Jeśli nie istnieje, pokaż okno z ContentView
        NSApplication.shared.windows.first?.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
}
