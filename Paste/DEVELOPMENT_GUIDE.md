# Paste - Development Guide

## Quick Start

```bash
cd /Users/pawelfil/FSV/Paste_ios/Paste
open Paste.xcodeproj
```

## Project Structure

```
Paste/
├── README.md                    # Opis projektu
├── PRD.md                       # Product Requirements Document
├── SETUP_INSTRUCTIONS.md        # Instrukcje konfiguracji Xcode
├── DEVELOPMENT_GUIDE.md         # Ten plik
├── LICENSE.md                   # MIT License
├── CHANGELOG.md                 # Historia zmian
├── CONTRIBUTING.md              # Jak przyczyniać się
├── .gitignore                   # Pliki do ignorowania Git
│
├── Paste/                       # Główny folder aplikacji
│   ├── PasteApp.swift          # Entry point aplikacji
│   │
│   ├── Models/
│   │   └── ClipboardItem.swift  # Model danych elementu historii
│   │
│   ├── Services/
│   │   ├── ClipboardService.swift    # Monitorowanie schowka
│   │   ├── HistoryManager.swift      # Zarządzanie historią
│   │   └── HotKeyManager.swift       # Obsługa skrótu globalnego
│   │
│   ├── Views/
│   │   ├── ContentView.swift         # Główny widok
│   │   ├── HistoryListView.swift     # Lista historii
│   │   └── ClipboardItemRow.swift    # Wiersz elementu
│   │
│   └── Utils/
│       └── Constants.swift           # Stałe aplikacji
```

## Główne komponenty

### ClipboardItem (Models)
- Reprezentacja pojedynczego elementu historii
- Zawiera: id, content, timestamp, type
- Generuje preview (pierwsze 100 znaków)
- Formatuje datę i godzinę

### HistoryManager (Services)
- Zarządza listą elementów historii
- Przechowuje do 10 elementów
- Obsługuje dodawanie, usuwanie, czyszczenie
- Persystencja w UserDefaults

### ClipboardService (Services)
- Monitoruje schowak co 0.5 sekundy
- Automatycznie dodaje nowe elementy do historii
- Ogranicza duplikaty (jeśli ostatni == nowy, to nie dodawaj)

### HotKeyManager (Services)
- Rejestruje globalny skrót cmd+shift+v
- Używa Core Graphics event tap
- Wymaga uprawnień Accessibility na macOS

### ContentView (Views)
- Główny widok aplikacji
- Menu bar integration
- Integracja z HotKeyManager

### HistoryListView (Views)
- Wyświetla listę elementów
- Wyszukiwanie w historii
- Przyciski do kopiowania i usuwania

## Proces Development

### 1. Build
```bash
Cmd+B w Xcode
```

### 2. Run
```bash
Cmd+R w Xcode
```

### 3. Test hotkey
- Uruchom aplikację
- Naciśnij cmd+shift+v
- Okno powinno się otworzyć

### 4. Debug
```bash
Cmd+Shift+D w Xcode (Debug navigator)
```

## Ważne uwagi

### Accessibility
Aby globalny skrót działał, aplikacja musi być w:
**System Settings → Privacy & Security → Accessibility**

### Pasteboard Access
Aplikacja monitoruje NSPasteboard.general w głównym threádzie

### Memory Management
- HistoryManager jest ObservableObject
- ClipboardService jest ObservableObject
- Zarówno się automatycznie czyszczą (deinit)

## Rozszerzanie projektu

### Dodanie nowego serwisu
1. Stwórz plik w `Services/`
2. Oznacz jako `ObservableObject` jeśli potrzebny binding
3. Zapamiętaj w `environmentObject()` w PasteApp

### Dodanie nowego widoku
1. Stwórz plik w `Views/`
2. Użyj `@ObservedObject` aby obserwować zmian
3. Dodaj `#Preview` blok

### Zmiana UI
- Wszystkie kolory są w Color extensions (Asset catalog)
- Rozmiary w Constants.swift
- Fonty używają SF Pro

## Troubleshooting

### Błąd: "Cannot find type 'ObservableObject' in scope"
- Przesprawdź czy Swift version to 5.5+
- Upewnij się że `import SwiftUI` jest w pliku

### Event tap nie działa
- Dodaj aplikację do Accessibility w System Settings
- Restart aplikacji

### Historia nie zapisuje się
- Sprawdź czy UserDefaults ma uprawnienia
- Sprawdź console dla błędów JSONEncoder

## Resources

- [Apple SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [macOS App Development](https://developer.apple.com/macos/)
- [NSPasteboard Reference](https://developer.apple.com/documentation/appkit/nspasteboard)
- [CGEvent Documentation](https://developer.apple.com/documentation/coregraphics/cgevent)
