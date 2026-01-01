import SwiftUI

/// Lista historii schowka
struct HistoryListView: View {
    @ObservedObject var historyManager: HistoryManager
    @State private var searchText = ""
    
    var filteredItems: [ClipboardItem] {
        if searchText.isEmpty {
            return historyManager.items
        } else {
            return historyManager.items.filter { $0.content.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Pasek wyszukiwania
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Szukaj w historii...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .background(Color(.controlBackgroundColor))
            
            Divider()
            
            if filteredItems.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)
                    
                    Text(searchText.isEmpty ? "Historia jest pusta" : "Nie znaleziono elementów")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    if searchText.isEmpty {
                        Text("Zacznij kopować, aby historię się wypełniła")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.textBackgroundColor))
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(filteredItems) { item in
                            ClipboardItemRow(
                                item: item,
                                onCopy: { content in
                                    copyToClipboard(content)
                                },
                                onDelete: { id in
                                    historyManager.removeItem(with: id)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
            
            Divider()
            
            // Pasek narzędzi
            HStack {
                Button(action: {
                    historyManager.clearHistory()
                }) {
                    Label("Wyczyść", systemImage: "trash")
                }
                .disabled(historyManager.items.isEmpty)
                
                Spacer()
                
                Text(filteredItems.count == historyManager.items.count
                    ? "\(historyManager.items.count) elementów"
                    : "\(filteredItems.count) z \(historyManager.items.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.controlBackgroundColor))
        }
    }
    
    private func copyToClipboard(_ content: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(content, forType: .string)
    }
}

#Preview {
    @State var historyManager = HistoryManager()
    
    HistoryListView(historyManager: historyManager)
        .onAppear {
            historyManager.addItem("Przykładowy tekst 1")
            historyManager.addItem("Drugi element")
            historyManager.addItem("https://example.com")
        }
}
