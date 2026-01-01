import SwiftUI

@available(macOS 13.0, *)
@main
struct PasteApp: App {
    @StateObject private var historyManager = HistoryManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(historyManager)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.automatic)
        
        // Menu bar
        MenuBarExtra("Paste", systemImage: "doc.on.clipboard") {
            VStack {
                Label("Historia schowka", systemImage: "doc.text")
                    .padding(.horizontal)
                    .padding(.top)
                
                Divider()
                
                if historyManager.items.isEmpty {
                    Text("Historia pusta")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(historyManager.items.prefix(5)) { item in
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.preview)
                                        .lineLimit(1)
                                        .font(.caption)
                                    
                                    Text(item.formattedTime)
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                .padding(8)
                                .background(Color(.controlBackgroundColor))
                                .cornerRadius(4)
                                .onTapGesture {
                                    copyToClipboard(item.content)
                                }
                                .help("Kliknij aby skopiować")
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 200)
                }
                
                Divider()
                
                HStack {
                    Button(action: {
                        openMainWindow()
                    }) {
                        Label("Otwórz historię", systemImage: "window.open")
                            .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {
                        historyManager.clearHistory()
                    }) {
                        Image(systemName: "trash")
                    }
                    .disabled(historyManager.items.isEmpty)
                }
                .padding()
                
                Divider()
                
                Button("Zamknij") {
                    NSApplication.shared.terminate(nil)
                }
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .frame(width: 300)
        }
    }
    
    private func openMainWindow() {
        if let window = NSApplication.shared.windows.first {
            window.makeKeyAndOrderFront(nil)
            NSApplication.shared.activate(ignoringOtherApps: true)
        }
    }
    
    private func copyToClipboard(_ content: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(content, forType: .string)
    }
}
