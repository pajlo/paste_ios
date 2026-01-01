import SwiftUI

/// Widok listy historii schowka
struct HistoryListView: View {
    @StateObject private var historyManager = HistoryManager.shared
    @State private var searchText = ""
    @State private var selectedItem: ClipboardItem?
    
    var filteredHistory: [ClipboardItem] {
        if searchText.isEmpty {
            return historyManager.history
        }
        return historyManager.search(query: searchText)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Historia schowka")
                        .font(.system(.headline, design: .default))
                    
                    Spacer()
                    
                    Button(action: clearHistory) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 14))
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.red)
                    .help("Wyczyść całą historię")
                }
                
                // Search bar
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Szukaj...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(12)
            .background(Color(.controlBackgroundColor))
            
            Divider()
            
            // History list
            if filteredHistory.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "clipboard.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)
                    
                    Text(searchText.isEmpty ? "Brak elementów w historii" : "Brak wyników")
                        .font(.system(.body, design: .default))
                        .foregroundColor(.secondary)
                    
                    if searchText.isEmpty {
                        Text("Skopiuj coś aby rozpocząć")
                            .font(.system(.caption, design: .default))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.textBackgroundColor))
                
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(filteredHistory) { item in
                            ClipboardItemRow(
                                item: item,
                                onDelete: { historyManager.removeItem(id: $0) },
                                onSelect: { selected in
                                    copyToClipboard(selected)
                                    selectedItem = selected
                                }
                            )
                        }
                    }
                    .padding(8)
                }
            }
            
            Divider()
            
            // Footer with info
            HStack(spacing: 8) {
                Text("Elementy: \(filteredHistory.count)")
                    .font(.system(.caption, design: .default))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Cmd+Shift+V aby otworzyć")
                    .font(.system(.caption, design: .default))
                    .foregroundColor(.secondary)
            }
            .padding(8)
            .background(Color(.controlBackgroundColor))
        }
        .frame(minWidth: Constants.windowWidth, minHeight: Constants.windowHeight)
    }
    
    private func copyToClipboard(_ item: ClipboardItem) {
        ClipboardService.shared.setContent(item.content)
    }
    
    private func clearHistory() {
        let alert = NSAlert()
        alert.messageText = "Czy na pewno chcesz wyczyścić historię?"
        alert.informativeText = "Nie będzie można cofnąć tej operacji."
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Wyczyść")
        alert.addButton(withTitle: "Anuluj")
        
        if alert.runModal() == .alertFirstButtonReturn {
            historyManager.clearHistory()
        }
    }
}

#Preview {
    HistoryListView()
}
