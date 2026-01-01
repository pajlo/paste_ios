import Foundation
import AppKit
import Carbon

/// Menedżer globalnych skrótów klawiszowych
class HotKeyManager: NSObject {
    static let shared = HotKeyManager()
    
    private var eventMonitor: Any?
    private var hotkeyHandler: (() -> Void)?
    
    // Cmd+Shift+V = V (keyCode 9), modifiers: command + shift
    private let hotKeyCode: UInt16 = 9
    private let hotKeyModifiers: NSEvent.ModifierFlags = [.command, .shift]
    
    override init() {
        super.init()
    }
    
    // MARK: - Public Methods
    
    /// Zarejestruj globalny hotkey
    func registerHotKey(handler: @escaping () -> Void) {
        hotkeyHandler = handler
        setupEventMonitor()
    }
    
    /// Wyrejestruj globalny hotkey
    func unregisterHotKey() {
        if let monitor = eventMonitor {
            NSEvent.removeMonitor(monitor)
            eventMonitor = nil
        }
    }
    
    // MARK: - Private Methods
    
    private func setupEventMonitor() {
        unregisterHotKey()
        
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyEvent(event)
        }
    }
    
    private func handleKeyEvent(_ event: NSEvent) {
        // Sprawdź keyCode i modifiers
        if event.keyCode == hotKeyCode {
            let modifiers = event.modifierFlags
            
            // Wyodrębnij tylko relevantne flagi
            let relevantModifiers: NSEvent.ModifierFlags = [.command, .shift, .control, .option]
            let eventModifiers = modifiers.intersection(relevantModifiers)
            
            // Porównaj tylko command + shift (pomijaj inne)
            if eventModifiers.contains(.command) && eventModifiers.contains(.shift) {
                // Upewnij się, że nie ma Control ani Option
                if !eventModifiers.contains(.control) && !eventModifiers.contains(.option) {
                    hotkeyHandler?()
                }
            }
        }
    }
    
    deinit {
        unregisterHotKey()
    }
}
