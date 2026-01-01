import Foundation
import AppKit

/// Serwis do monitorowania zmian w schowku systemowym
@available(macOS 13.0, *)
class ClipboardService: ObservableObject {
    @Published var currentContent: String = ""
    
    private var changeCount: Int = 0
    private var timer: Timer?
    private let historyManager: HistoryManager
    
    init(historyManager: HistoryManager) {
        self.historyManager = historyManager
        self.changeCount = NSPasteboard.general.changeCount
        startMonitoring()
    }
    
    /// Rozpoczyna monitorowanie schowka
    private func startMonitoring() {
        // Monitoruj zmiany w schowku co 0.5 sekundy
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkClipboard()
        }
    }
    
    /// Zatrzymuje monitorowanie schowka
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
    
    /// Sprawdza zmiany w schowku
    private func checkClipboard() {
        let pasteboard = NSPasteboard.general
        
        // Jeśli changeCount się zmienił, zawartość się zmieniła
        if pasteboard.changeCount != changeCount {
            changeCount = pasteboard.changeCount
            
            // Spróbuj pobrać tekst
            if let text = pasteboard.string(forType: .string) {
                DispatchQueue.main.async {
                    self.currentContent = text
                    self.historyManager.addItem(text)
                }
            }
        }
    }
    
    deinit {
        stopMonitoring()
    }
}
