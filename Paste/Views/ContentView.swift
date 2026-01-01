import SwiftUI

/// Główny widok aplikacji
struct ContentView: View {
    @StateObject private var historyManager = HistoryManager.shared
    @StateObject private var clipboardService = ClipboardService.shared
    
    var body: some View {
        HistoryListView()
    }
}

#Preview {
    ContentView()
}
