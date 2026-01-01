# Paste - macOS Clipboard History Manager

## Opis

**Paste** to aplikacja macOS, która automatycznie zapamiętuje ostatnie 10 skopiowanych elementów ze schowka. Dzięki skrótowi klawiszowemu `Cmd+Shift+V` możesz szybko dostać się do historii i przywrócić dowolny wcześniej skopiowany tekst, obraz lub plik.

## Funkcjonalności

- 📋 **Historia schowka** - Automatyczne zapisywanie ostatnich 10 elementów
- ⚡ **Szybki dostęp** - Globalna skrótu `Cmd+Shift+V` do otwarcia interfejsu
- 🔍 **Wyszukiwanie** - Możliwość wyszukiwania w historii
- 📊 **Metadane** - Timestamp i typ zawartości dla każdego elementu
- ☁️ **iCloud Sync** (opcjonalnie) - Synchronizacja historii między urządzeniami
- 🎨 **Czysty UI** - Nowoczesny interfejs w SwiftUI

## Wymagania

- macOS 12.0 lub nowszej
- Xcode 14.0+
- Swift 5.7+

## Instalacja

```bash
# Clone repozytorium
git clone <repo-url>
cd Paste_ios

# Otwórz projekt w Xcode
open Paste/Paste.xcodeproj
```

## Budowanie

```bash
# Debug
xcodebuild -scheme Paste -configuration Debug

# Release
xcodebuild -scheme Paste -configuration Release -archivePath ./build/Paste.xcarchive archive
```

## Użycie

1. Uruchom aplikację
2. Skopiuj zawartość do schowka (Cmd+C)
3. Naciśnij `Cmd+Shift+V` aby otworzyć historię
4. Wybierz element z listy aby go przywrócić do schowka

## Struktura projektu

```
Paste/
├── Models/              # Modele danych
├── Services/            # Logika biznesowa (clipboard, history, hotkeys)
├── Views/               # SwiftUI widoki
├── Utils/               # Narzędzia i stałe
└── PasteApp.swift       # Entry point aplikacji
Tests/                   # Testy jednostkowe
docs/                    # Dokumentacja
Scripts/                 # Skrypty budowania
```

## Architektura

### Komponenty

- **ClipboardService** - Obsługuje dostęp do systemowego schowka
- **HistoryManager** - Zarządza historią (dodawanie, usuwanie, pobieranie)
- **HotKeyManager** - Rejestruje globalne skróty klawiszowe
- **ClipboardItem** - Model reprezentujący element historii

### Przepływ danych

```
ClipboardService (monitor schowka)
        ↓
HistoryManager (przechowuje, limituje do 10)
        ↓
ContentView (wyświetla historię)
```

## Konfiguracja

Edytuj `Paste/Utils/Constants.swift` aby zmienić:
- Limit historii (domyślnie 10)
- Skrót klawiszowy (domyślnie Cmd+Shift+V)
- Ścieżkę przechowywania danych

## Debugowanie

```bash
# Wyświetl logi
log stream --predicate 'process == "Paste"'

# Reset historii
defaults delete com.pajlo.Paste history
```

## Licencja

MIT - patrz `LICENSE.md`

## Autor

pajlo (pawelmateuszfil@gmail.com)

## Wspieranie projektu

Jeśli masz sugestie lub znalazłeś bug, otwórz issue lub PR.
