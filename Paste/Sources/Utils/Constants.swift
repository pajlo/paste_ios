import Foundation

/// Stałe aplikacji
struct Constants {
    // MARK: - Wymiary
    struct Size {
        static let windowWidth: CGFloat = 600
        static let windowHeight: CGFloat = 500
        static let itemRowHeight: CGFloat = 60
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - Kolory
    struct Colors {
        static let accentColor = "AccentColor"
        static let backgroundColor = "BackgroundColor"
    }
    
    // MARK: - Serwis schowka
    struct Clipboard {
        static let maxHistoryItems = 10
        static let monitoringInterval: TimeInterval = 0.5
    }
    
    // MARK: - Historia
    struct History {
        static let storageKey = "clipboard_history"
        static let previewMaxLength = 100
    }
    
    // MARK: - HotKey
    struct HotKey {
        static let vKeyCode: UInt32 = 9 // Kod klawisza V
        static let cmdModifier: UInt32 = 1 << 20
        static let shiftModifier: UInt32 = 1 << 17
    }
}
