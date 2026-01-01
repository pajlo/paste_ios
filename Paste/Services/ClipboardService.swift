import Foundation
import AppKit

/// Serwis do obsługi systemowego schowka macOS
class ClipboardService: ObservableObject {
    static let shared = ClipboardService()
    
    @Published private(set) var currentContent: String = ""
    @Published var onClipboardChange: (() -> Void)?
    
    private var lastChangeTime: Date = Date()
    private var monitoringTimer: Timer?
    private let checkInterval: TimeInterval = 0.5  // Co 500ms sprawdzamy schowak
    private var lastChangeCount: Int = 0
    
    private init() {
        updateCurrentContent()
    }
    
    // MARK: - Public Methods
    
    /// Uruchom monitorowanie schowka w tle
    func startMonitoring() {
        stopMonitoring()
        
        // Pobierz obecny stan schowka
        lastChangeCount = NSPasteboard.general.changeCount
        
        // Stwórz timer do periodycznego sprawdzania zmian
        monitoringTimer = Timer.scheduledTimer(withTimeInterval: checkInterval, repeats: true) { [weak self] _ in
            self?.checkForChanges()
        }
        
        // Uruchom timer natychmiast
        RunLoop.current.add(monitoringTimer ?? Timer(), forMode: .common)
    }
    
    /// Zatrzymaj monitorowanie schowka
    func stopMonitoring() {
        monitoringTimer?.invalidate()
        monitoringTimer = nil
    }
    
    /// Pobierz aktualną zawartość schowka jako String
    func getCurrentContent() -> String? {
        let pasteboard = NSPasteboard.general
        
        // Próbuj pobrać jako tekst
        if let stringData = pasteboard.string(forType: .string) {
            return stringData
        }
        
        // Jeśli nie ma tekstu, sprawdź obrazek
        if let image = NSImage(pasteboard: pasteboard) {
            return "[Obraz \(Int(image.size.width))x\(Int(image.size.height))]"
        }
        
        // Sprawdź URL/plik
        if let urls = pasteboard.readObjects(forClasses: [NSURL.self]) as? [NSURL] {
            return urls.map { $0.lastPathComponent ?? "plik" }.joined(separator: ", ")
        }
        
        return nil
    }
    
    /// Ustaw zawartość schowka
    func setContent(_ string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(string, forType: .string)
        updateCurrentContent()
    }
    
    /// Pobierz typ zawartości schowka
    func getContentType() -> ClipboardItem.ContentType {
        let pasteboard = NSPasteboard.general
        
        // Sprawdź obrazek
        if pasteboard.availableTypeFromArray([.png, .tiff, .pdf]) != nil {
            return .image
        }
        
        // Sprawdź pliki
        if pasteboard.availableTypeFromArray([.fileURL]) != nil {
            return .file
        }
        
        // Default to text
        return .text
    }
    
    // MARK: - Private Methods
    
    private func checkForChanges() {
        let currentChangeCount = NSPasteboard.general.changeCount
        
        if currentChangeCount != lastChangeCount {
            lastChangeCount = currentChangeCount
            updateCurrentContent()
            onClipboardChange?()
        }
    }
    
    private func updateCurrentContent() {
        if let content = getCurrentContent() {
            currentContent = content
            lastChangeTime = Date()
        }
    }
    
    deinit {
        stopMonitoring()
    }
}
