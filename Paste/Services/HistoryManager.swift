import Foundation

/// Menedżer historii schowka - zarządza przechowywaniem i pobieraniem elementów
class HistoryManager: NSObject, ObservableObject {
    static let shared = HistoryManager()
    
    @Published private(set) var history: [ClipboardItem] = []
    private let storageKey = "com.pajlo.paste.history"
    private let maxItems = 10
    private let queue = DispatchQueue(label: "com.pajlo.paste.history", attributes: .concurrent)
    
    override init() {
        super.init()
        loadFromStorage()
    }
    
    // MARK: - Public Methods
    
    /// Dodaj nowy element do historii
    func addItem(_ item: ClipboardItem) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            
            // Usuń duplikaty (jeśli element o tej samej zawartości już istnieje)
            self.history.removeAll { $0.content == item.content }
            
            // Dodaj nowy element na początek
            self.history.insert(item, at: 0)
            
            // Ogranicz do maxItems
            if self.history.count > self.maxItems {
                self.history = Array(self.history.prefix(self.maxItems))
            }
            
            // Zapisz do storage
            DispatchQueue.main.async {
                self.saveToStorage()
                self.objectWillChange.send()
            }
        }
    }
    
    /// Pobierz całą historię
    func getHistory() -> [ClipboardItem] {
        var result: [ClipboardItem] = []
        queue.sync {
            result = self.history
        }
        return result
    }
    
    /// Usuń element z historii
    func removeItem(id: UUID) {
        queue.async(flags: .barrier) { [weak self] in
            self?.history.removeAll { $0.id == id }
            DispatchQueue.main.async {
                self?.saveToStorage()
                self?.objectWillChange.send()
            }
        }
    }
    
    /// Wyczyść całą historię
    func clearHistory() {
        queue.async(flags: .barrier) { [weak self] in
            self?.history.removeAll()
            DispatchQueue.main.async {
                self?.saveToStorage()
                self?.objectWillChange.send()
            }
        }
    }
    
    /// Wyszukaj w historii (case-insensitive)
    func search(query: String) -> [ClipboardItem] {
        let lowercaseQuery = query.lowercased()
        return history.filter { item in
            item.content.lowercased().contains(lowercaseQuery) ||
            item.preview.lowercased().contains(lowercaseQuery)
        }
    }
    
    // MARK: - Storage
    
    /// Zapisz historię do UserDefaults
    func saveToStorage() {
        do {
            let data = try JSONEncoder().encode(history)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Błąd przy zapisywaniu historii: \(error)")
        }
    }
    
    /// Załaduj historię z UserDefaults
    func loadFromStorage() {
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            
            if let data = UserDefaults.standard.data(forKey: self.storageKey) {
                do {
                    let decoded = try JSONDecoder().decode([ClipboardItem].self, from: data)
                    self.history = decoded
                } catch {
                    print("Błąd przy ładowaniu historii: \(error)")
                    self.history = []
                }
            }
            
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
}
