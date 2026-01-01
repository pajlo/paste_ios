import Foundation
import AppKit

/// Typ reprezentujący globalny skrót klawiszowy
typealias HotKeyHandler = () -> Void

/// Serwis do obsługi globalnych skrótów klawiszowych
class HotKeyManager {
    private var hotKeys: [UInt32: HotKeyHandler] = [:]
    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?
    
    static let shared = HotKeyManager()
    
    private init() {
        setupEventTap()
    }
    
    /// Rejestruje globalny skrót klawiszowy
    /// - Parameters:
    ///   - keyCode: Kod klawisza
    ///   - modifiers: Kombinacja modyfikatorów (cmd, shift, itp)
    ///   - handler: Funkcja wywoływana gdy skrót jest wciśnięty
    func register(keyCode: UInt32, modifiers: UInt32, handler: @escaping HotKeyHandler) {
        hotKeys[keyCode] = handler
    }
    
    /// Konfiguruje event tap do przechwytywania zdarzeń klawiatury
    private func setupEventTap() {
        let eventMask = CGEventMask(1 << CGEventType.keyDown.rawValue)
        
        guard let tap = CGEvent.tapCreate(
            tap: .cghidEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: eventMask,
            callback: eventTapCallback,
            userInfo: Unmanaged.passUnretained(self).toOpaque()
        ) else {
            print("Nie udało się stworzyć event tapa")
            return
        }
        
        self.eventTap = tap
        
        let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
        self.runLoopSource = runLoopSource
        
        if let source = runLoopSource {
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, .commonModes)
        }
    }
    
    deinit {
        if let tap = eventTap {
            CFMachPortInvalidate(tap)
        }
    }
}

/// Callback dla event tapa
private func eventTapCallback(
    proxy: CGEventTapProxy,
    type: CGEventType,
    event: CGEvent,
    userInfo: UnsafeMutableRawPointer?
) -> Unmanaged<CGEvent>? {
    guard let userInfo = userInfo else { return Unmanaged.passRetained(event) }
    
    let manager = Unmanaged<HotKeyManager>.fromOpaque(userInfo).takeUnretainedValue()
    
    // Sprawdź czy wciśnięty jest cmd+shift+v
    let flags = event.flags
    let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
    
    // cmd (0x0100) + shift (0x0200) + v (0x09)
    if flags.contains(.maskCommand) && flags.contains(.maskShift) && keyCode == 9 {
        print("cmd+shift+v wciśnięty!")
        // Wywołaj handler
        if let handler = manager.hotKeys[UInt32(keyCode)] {
            handler()
        }
    }
    
    return Unmanaged.passRetained(event)
}
