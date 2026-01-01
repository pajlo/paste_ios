# Instrukcja Tworzenia Projektu Xcode

## Krok 1: Utwórz nowy projekt w Xcode

1. Otwórz **Xcode**
2. Wybierz **File** → **New** → **Project**
3. Wybierz **macOS** → **App** → **Next**
4. Ustaw poniższe parametry:
   - **Product Name**: `Paste`
   - **Team**: (twój Team)
   - **Organization Identifier**: `com.yourname`
   - **Language**: `Swift`
   - **User Interface**: `SwiftUI`
   - **Życie cyklu**: `None`

## Krok 2: Skopiuj pliki Swift

Skopiuj wszystkie pliki z folderu `Paste/` do folderu projektu Xcode:

```
Paste/
├── Paste/
│   ├── PasteApp.swift
│   ├── Views/
│   │   ├── ContentView.swift
│   │   ├── HistoryListView.swift
│   │   └── ClipboardItemRow.swift
│   ├── Models/
│   │   └── ClipboardItem.swift
│   ├── Services/
│   │   ├── ClipboardService.swift
│   │   ├── HistoryManager.swift
│   │   └── HotKeyManager.swift
│   └── Utils/
│       └── Constants.swift
```

## Krok 3: Konfiguracja projektu w Xcode

1. **Build Settings**:
   - Ustaw **Minimum Deployment Target** na **macOS 12.0**
   - Upewnij się, że **Swift Language Version** to **Swift 5.5+**

2. **Signing & Capabilities**:
   - Zaznacz **Automatically manage signing**
   - Wybierz swój Team

3. **Info.plist**:
   Dodaj następujące uprawnienia (jeśli automatycznie nie zostały dodane):
   ```xml
   <key>NSHumanReadableCopyright</key>
   <string>Copyright © 2025 Paste. All rights reserved.</string>
   ```

## Krok 4: Dodaj plik SVG dla ikony (opcjonalnie)

W **Assets.xcassets** dodaj właśćiwą ikonę aplikacji.

## Krok 5: Build i uruchomienie

```bash
cd /Users/pawelfil/FSV/Paste_ios/Paste
open Paste.xcodeproj
```

W Xcode:
- **Cmd+B** - Build
- **Cmd+R** - Uruchom
- **Cmd+U** - Testy

## Krok 6: Uprawnienia macOS

Aby aplikacja mogła monitorować schowek i obsługiwać globalne skróty klawiszowe, może być wymagane:

1. Przejdź do **System Settings** → **Privacy & Security**
2. Sprawdź czy aplikacja ma dostęp do:
   - Accessibility (dla globalnych skrótów)
   - Pasteboard/Clipboard

## Notatki Ważne

- Aplikacja korzysta z `NSPasteboard.general` do dostępu do schowka
- Event tap dla globalnych skrótów wymaga uprawnień Accessibility
- Dane są przechowywane w `UserDefaults` (lokalnie)
- Historia ograniczona do 10 elementów

## Troubleshooting

**Problem**: Skrót cmd+shift+v nie działa
**Rozwiązanie**: Dodaj aplikację do System Settings → Privacy & Security → Accessibility

**Problem**: Aplikacja się nie uruchamia
**Rozwiązanie**: Sprawdź czy wszystkie pliki Swift są w **Target Membership**

**Problem**: Build error
**Rozwiązanie**: 
- Clean Build Folder (Cmd+Shift+K)
- Rebuild (Cmd+B)
