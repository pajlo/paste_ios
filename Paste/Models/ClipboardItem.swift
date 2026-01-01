import Foundation

/// Reprezentuje pojedynczy element historii schowka
struct ClipboardItem: Identifiable, Codable {
    let id: UUID
    var content: String
    var contentType: ContentType
    var timestamp: Date
    var metadata: [String: String]?
    
    /// Typ zawartości skopiowanej do schowka
    enum ContentType: String, Codable, Hashable {
        case text = "text"
        case image = "image"
        case file = "file"
        
        var displayName: String {
            switch self {
            case .text: return "Tekst"
            case .image: return "Obraz"
            case .file: return "Plik"
            }
        }
    }
    
    /// Inilializer
    init(
        content: String,
        contentType: ContentType = .text,
        timestamp: Date = Date(),
        metadata: [String: String]? = nil,
        id: UUID = UUID()
    ) {
        self.id = id
        self.content = content
        self.contentType = contentType
        self.timestamp = timestamp
        self.metadata = metadata
    }
    
    /// Preview zawartości (obcięty tekst do 100 znaków)
    var preview: String {
        let text = content.replacingOccurrences(of: "\n", with: " ")
        return text.count > 100 ? String(text.prefix(100)) + "..." : text
    }
    
    /// Sformatowana data i godzina
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter.string(from: timestamp)
    }
    
    /// Hash dla porównywania
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// Równość
    static func == (lhs: ClipboardItem, rhs: ClipboardItem) -> Bool {
        lhs.id == rhs.id
    }
}
