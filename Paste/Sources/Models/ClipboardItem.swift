import Foundation

/// Typ danych w schowku
enum ClipboardType: String, Codable {
    case text
    case url
    case image
    case other
}

/// Model reprezentujący pojedynczy element historii schowka
struct ClipboardItem: Codable, Identifiable, Equatable {
    let id: UUID
    let content: String
    let timestamp: Date
    let type: ClipboardType
    
    /// Zwraca skrócony podgląd zawartości (pierwsze 100 znaków)
    var preview: String {
        let maxLength = 100
        if content.count > maxLength {
            return String(content.prefix(maxLength)) + "..."
        }
        return content
    }
    
    /// Zwraca sformatowaną datę i godzinę
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "pl_PL")
        return formatter.string(from: timestamp)
    }
    
    init(content: String, type: ClipboardType = .text) {
        self.id = UUID()
        self.content = content
        self.timestamp = Date()
        self.type = type
    }
    
    init(id: UUID, content: String, timestamp: Date, type: ClipboardType) {
        self.id = id
        self.content = content
        self.timestamp = timestamp
        self.type = type
    }
}
