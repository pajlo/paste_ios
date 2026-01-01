import SwiftUI

/// Wiersz reprezentujący element historii
@available(macOS 13.0, *)
struct ClipboardItemRow: View {
    let item: ClipboardItem
    let onCopy: (String) -> Void
    let onDelete: (UUID) -> Void
    
    @State private var isHovering = false
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.preview)
                    .lineLimit(2)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Text(item.formattedTime)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Przyciski akcji
            if isHovering {
                HStack(spacing: 8) {
                    Button(action: {
                        onCopy(item.content)
                    }) {
                        Image(systemName: "doc.on.doc")
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(.plain)
                    .help("Skopiuj do schowka")
                    
                    Button(action: {
                        onDelete(item.id)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)
                    .help("Usuń z historii")
                }
                .transition(.opacity)
            }
        }
        .padding(12)
        .background(Color(.controlBackgroundColor))
        .cornerRadius(8)
        .onHover { hovering in
            isHovering = hovering
        }
    }
}
