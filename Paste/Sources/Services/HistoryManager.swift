import Foundation

/// Serwis do zarządzania historią schowka
@available(macOS 13.0, *)
class HistoryManager: ObservableObject {
    @Published var items: [ClipboardItem] = []
    
    private let defaults = UserDefaults.standard
    private let historyKey = "clipboard_history"
    private let maxItems = 10
    
    init() {
        loadHistory()
    }
    
    /// Dodaje nowy element do historii
    func addItem(_ content: String) {
        // Sprawdzenie, czy element jest identyczny z ostatnim
        if let lastItem = items.first, lastItem.content == content {
            return // Nie dodawaj duplikatu
        }
        
        let newItem = ClipboardItem(content: content)
        items.insert(newItem, at: 0)
        
        // Ogranicz do maksymalnie 10 elementów
        if items.count > maxItems {
            items = Array(items.prefix(maxItems))
        }
        
        saveHistory()
    }
    
    /// Usuwa element z historii
    func removeItem(with id: UUID) {
        items.removeAll { $0.id == id }
        saveHistory()
    }
    
    /// Usuwa wszystkie elementy z historii
    func clearHistory() {
        items.removeAll()
        saveHistory()
    }
    
    /// Zapisuje historię do UserDefaults
    private func saveHistory() {
        do {
            let data = try JSONEncoder().encode(items)
            defaults.set(data, forKey: historyKey)
        } catch {
            print("Błąd podczas zapisywania historii: \(error)")
        }
    }
    
    /// Wczytuje historię z UserDefaults
    private func loadHistory() {
        guard let data = defaults.data(forKey: historyKey) else {
            return
        }
        
        do {
            items = try JSONDecoder().decode([ClipboardItem].self, from: data)
        } catch {
            print("Błąd podczas wczytywania historii: \(error)")
            items = []
        }
    }
}
