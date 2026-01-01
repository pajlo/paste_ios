import SwiftUI

/// Pojedynczy wiersz w liście historii
struct ClipboardItemRow: View {
    let item: ClipboardItem
    var onDelete: (UUID) -> Void
    var onSelect: (ClipboardItem) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon based on content type
            Image(systemName: iconName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.blue)
                .frame(width: 24)
            
            // Content preview and metadata
            VStack(alignment: .leading, spacing: 4) {
                Text(item.preview)
                    .font(.system(.body, design: .default))
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                HStack(spacing: 8) {
                    Text(item.contentType.displayName)
                        .font(.system(.caption, design: .default))
                        .foregroundColor(.secondary)
                    
                    Divider()
                        .frame(height: 12)
                    
                    Text(item.formattedTime)
                        .font(.system(.caption, design: .default))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Delete button
            Button(action: { onDelete(item.id) }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
            .help("Usuń element")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onSelect(item)
        }
        .frame(height: Constants.itemRowHeight)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(.controlBackgroundColor))
        .cornerRadius(4)
    }
    
    private var iconName: String {
        switch item.contentType {
        case .text: return "doc.text.fill"
        case .image: return "photo.fill"
        case .file: return "folder.fill"
        }
    }
}

#Preview {
    let item = ClipboardItem(
        content: "To jest przykładowy tekst ze schowka",
        contentType: .text,
        timestamp: Date()
    )
    ClipboardItemRow(
        item: item,
        onDelete: { _ in },
        onSelect: { _ in }
    )
}
