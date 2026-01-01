# Development Guide - Paste

## Przygotowanie środowiska

### Wymagania
- macOS 12.0+
- Xcode 14.0+ (z Swift 5.7+)
- Git

### Instalacja

```bash
# Klonowanie repozytorium
git clone <repo-url>
cd Paste_ios

# Instalacja zależności (jeśli używane)
# TBD

# Otwarcie projektu w Xcode
open Paste/Paste.xcodeproj
```

## Struktura kodu

### Models (`Paste/Models/`)

#### `ClipboardItem.swift`
Reprezentuje pojedynczy element historii.

```swift
struct ClipboardItem: Identifiable, Codable {
    let id: UUID
    var content: String
    var contentType: ContentType
    var timestamp: Date
    var metadata: [String: String]?
    
    enum ContentType: String, Codable {
        case text
        case image
        case file
    }
}
```

**Codable:** Umożliwia serializację do JSON dla UserDefaults.

### Services (`Paste/Services/`)

#### `ClipboardService.swift`
Obsługuje dostęp do systemowego schowka.

**Główne metody:**
- `getCurrentContent()` → String? - Pobierz aktualną zawartość
- `setContent(_ string: String)` - Ustaw zawartość schowka
- `startMonitoring(onChange:)` - Monitoruj zmiany schowka

**Implementacja:**
- Używa `NSPasteboard` do dostępu do schowka
- Timer do periodycznego sprawdzania zmian
- CallBack na zmianę zawartości

#### `HistoryManager.swift`
Zarządza historią elementów schowka.

**Główne metody:**
- `addItem(_ item: ClipboardItem)` - Dodaj do historii
- `getHistory()` → [ClipboardItem] - Pobierz wszystkie
- `removeItem(id: UUID)` - Usuń element
- `clearHistory()` - Wyczyść całą historię
- `saveToStorage()` - Zachowaj do UserDefaults
- `loadFromStorage()` - Załaduj z UserDefaults

**Storage:**
- Przechowuje max 10 elementów
- Serializuje do JSON za pośrednictwem UserDefaults
- Key: `com.pajlo.paste.history`

#### `HotKeyManager.swift`
Rejestruje globalne skróty klawiszowe.

**Główne metody:**
- `registerHotKey(keyCode:modifiers:handler:)` - Rejestruj hotkey
- `unregisterHotKey()` - Usuń rejestrację
- `setEventMonitor()` - Setup event monitoring

**Implementacja:**
- Używa `EventTap` lub `NSEvent.addGlobalMonitorForEvents`
- Cmd+Shift+V = KeyCode 9, modifiers [.command, .shift]
- Requires Accessibility permissions

### Views (`Paste/Views/`)

#### `ContentView.swift`
Główny widok aplikacji - lista historii.

**Komponenty:**
- Search bar (tekstowe filtrowanie)
- List z ClipboardItemRow
- Empty state (brak elementów)

**State Management:**
- `@StateObject HistoryManager` - Historia
- `@State var searchText: String` - Filter tekst

#### `HistoryListView.swift`
Dedykowany widok listy (opcjonalnie).

#### `ClipboardItemRow.swift`
Pojedynczy element listy.

**Wyświetla:**
- Preview zawartości (obcięty tekst lub thumbnail)
- Timestamp
- Typ (ikona)
- Przycisk usuwania (X)
- Akcja: Kliknięcie = kopiuj do schowka

### Utils (`Paste/Utils/`)

#### `Constants.swift`
Stałe konfiguracyjne.

```swift
enum Config {
    static let maxHistoryItems = 10
    static let hotKeyCode: UInt16 = 9  // V
    static let hotKeyModifiers: NSEvent.ModifierFlags = [.command, .shift]
    static let updateCheckInterval: TimeInterval = 0.5  // seconds
    static let maxItemSize: Int = 5 * 1024 * 1024  // 5MB
    static let storageKey = "com.pajlo.paste.history"
}
```

## Przepływ aplikacji

### Startup
```
PasteApp.swift
├─ AppDelegate setupuje HotKeyManager
├─ HistoryManager loadFromStorage()
├─ ClipboardService.startMonitoring()
└─ ContentView renderuje UI
```

### Na zmianę schowka
```
ClipboardService.monitor
└─ onChange callback
    └─ HistoryManager.addItem()
        ├─ limit do 10
        └─ saveToStorage() → UserDefaults
```

### Na Cmd+Shift+V
```
HotKeyManager event tap
└─ open ContentView window
    └─ user selects item
        ├─ ClipboardService.setContent()
        └─ Close window
```

## Testy

### Unit Tests (Tests/)
```bash
xcodebuild test -scheme Paste
```

**Testowe scenariusze:**
- `HistoryManagerTests` - Dodawanie, usuwanie, limit
- `ClipboardServiceTests` - Zapis/odczyt schowka
- `ClipboardItemTests` - Serializacja JSON

### Manual Testing
1. Skopiuj tekst → Sprawdź czy pojawi się w historii
2. Skopiuj obraz → Sprawdź preview
3. Usuń element → Sprawdź czy znika z historii
4. Restart aplikacji → Sprawdź czy historia się zaladuje
5. Cmd+Shift+V → Sprawdź otwarcie okna

## Debugging

### Logs
```bash
# Streamuj logi Paste
log stream --predicate 'process == "Paste"'

# Lub w Xcode: View > Navigators > Show Debug Navigator
```

### Accessibility Prompt
Na pierwszym uruchomieniu użytkownik dostanie prompt o uprawnienia Accessibility.
W ustawieniach: System Settings > Privacy & Security > Accessibility > Paste

### Reset danych
```bash
# Wyczyść historię z UserDefaults
defaults delete com.pajlo.paste.history

# Wyczyść wszystkie preferencje
defaults delete com.pajlo.paste
```

## Build & Release

### Debug Build
```bash
xcodebuild -scheme Paste -configuration Debug -derivedDataPath ./build
```

### Release Build
```bash
xcodebuild -scheme Paste -configuration Release \
  -archivePath ./build/Paste.xcarchive \
  archive

# Export archive
xcodebuild -exportArchive \
  -archivePath ./build/Paste.xcarchive \
  -exportPath ./build/Paste.app \
  -exportOptionsPlist ./Scripts/ExportOptions.plist
```

## Code Style

### Swift Style Guide
- **Indentation:** 4 spaces
- **Line length:** Max 100 characters
- **Naming:**
  - Classes/Structs: PascalCase
  - Functions/Variables: camelCase
  - Constants: UPPER_SNAKE_CASE
- **Access Control:** Explicit (public, private, internal)

### Linting
```bash
# TBD - Dodaj SwiftLint
swiftlint
```

## Git Workflow

### Branches
- `main` - Production ready
- `develop` - Integration branch
- `feature/*` - Nowe funkcjonalności
- `bugfix/*` - Poprawki błędów

### Commits
```
<type>(<scope>): <subject>

<body>

Fixes #<issue>
```

**Typy:** feat, fix, docs, style, refactor, test, chore

**Przykład:**
```
feat(history): add search functionality

- Implementuj wyszukiwanie Case-insensitive
- Filtruj w real-time
- Highlight matched text

Fixes #123
```

## FAQ

**P: Gdzie przechowywane są dane?**  
O: W `~/Library/Preferences/com.pajlo.paste.plist` (UserDefaults)

**P: Czy mogę zmienić limit historii?**  
O: Tak, edytuj `Config.maxHistoryItems` w Constants.swift

**P: Jak wyłączyć monitorowanie schowka?**  
O: Wyłącz aplikację - monitoring zatrzymuje się automatycznie

**P: Czy mogę dodać iCloud sync?**  
O: Tak, używając CloudKit i NSUbiquitousKeyValueStore (v2.0)

## Zasoby

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [NSPasteboard](https://developer.apple.com/documentation/appkit/nspasteboard)
- [EventTap](https://developer.apple.com/documentation/quartz/1454351-cgeventtapcreate)
- [macOS App Development](https://developer.apple.com/documentation/macos)
