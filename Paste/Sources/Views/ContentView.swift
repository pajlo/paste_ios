import SwiftUI

/// Główny widok aplikacji
@available(macOS 13.0, *)
struct ContentView: View {
    @StateObject private var historyManager = HistoryManager()
    @StateObject private var clipboardService: ClipboardService
    @State private var isWindowVisible = true
    
    init() {
        let manager = HistoryManager()
        let service = ClipboardService(historyManager: manager)
        _historyManager = StateObject(wrappedValue: manager)
        _clipboardService = StateObject(wrappedValue: service)
    }
    
    var body: some View {
        ZStack {
            // Tło
            Color(.textBackgroundColor)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Nagłówek
                VStack(spacing: 8) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Paste")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Historia schowka • cmd+shift+v")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            NSApplication.shared.keyWindow?.close()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.secondary)
                        }
                        .buttonStyle(.plain)
                        .help("Zamknij okno (cmd+shift+v aby otworzyć)")
                    }
                    .padding()
                }
                .background(Color(.controlBackgroundColor))
                
                // Historia
                HistoryListView(historyManager: historyManager)
            }
        }
        .frame(minWidth: 500, idealWidth: 600, minHeight: 400)
        .onAppear {
            setupHotKey()
        }
        .onDisappear {
            clipboardService.stopMonitoring()
        }
    }
    
    private func setupHotKey() {
        // Rejestruj globalny skrót cmd+shift+v
        HotKeyManager.shared.register(
            keyCode: Constants.HotKey.vKeyCode,
            modifiers: Constants.HotKey.cmdModifier | Constants.HotKey.shiftModifier
        ) {
            DispatchQueue.main.async {
                toggleWindowVisibility()
            }
        }
    }
    
    private func toggleWindowVisibility() {
        if let window = NSApplication.shared.keyWindow {
            if window.isVisible {
                window.orderOut(nil)
            } else {
                window.makeKeyAndOrderFront(nil)
                NSApplication.shared.activate(ignoringOtherApps: true)
            }
        }
    }
}
