import Foundation

/// Stałe konfiguracyjne aplikacji
struct Constants {
    // MARK: - App Configuration
    static let appName = "Paste"
    static let appVersion = "1.0.0"
    static let bundleIdentifier = "com.pajlo.paste"
    
    // MARK: - History Configuration
    static let maxHistoryItems = 10
    static let updateCheckInterval: TimeInterval = 0.5
    static let maxItemSize: Int = 5 * 1024 * 1024  // 5MB
    
    // MARK: - Hotkey Configuration
    static let hotKeyCode: UInt16 = 9  // V key
    // Modifiers: command (⌘) + shift (⇧)
    
    // MARK: - Storage
    static let historyStorageKey = "com.pajlo.paste.history"
    
    // MARK: - UI
    static let windowWidth: CGFloat = 400
    static let windowHeight: CGFloat = 500
    static let cornerRadius: CGFloat = 8
    static let itemRowHeight: CGFloat = 60
}
