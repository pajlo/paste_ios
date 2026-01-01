# Changelog - Paste

Wszystkie istotne zmiany w tym projekcie będą dokumentowane w tym pliku.

Format ten jest oparty na [Keep a Changelog](https://keepachangelog.com/).

## [1.0.0] - 2026-01-01

### Added
- ✨ Monitorowanie systemowego schowka w tle
- 📋 Historia ostatnich 10 skopiowanych elementów
- ⚡ Globalny skrót `Cmd+Shift+V` do otwarcia historii
- 🎨 SwiftUI interfejs z listą elementów
- 🔍 Preview zawartości (tekst obcięty, thumbnail dla obrazów)
- ⏱️ Timestamp dla każdego elementu
- 🗑️ Usuwanie pojedynczych elementów z historii
- 💾 Persistence danych do UserDefaults
- 📊 Metadane (typ zawartości: tekst/obraz/plik)
- ♿ Uprawnienia Accessibility do globalnego hotkey
- 📱 Support dla macOS 12.0+

### Technical Details
- **Architecture:** MVVM z SwiftUI
- **Services:** ClipboardService, HistoryManager, HotKeyManager
- **Storage:** NSUserDefaults (local persistence)
- **Framework:** SwiftUI, AppKit (dla hotkey i clipboard)
- **Minimum deployment:** macOS 12.0
- **Swift:** 5.7+

## [1.1.0] - Planned

### Planned Features
- 🔎 Wyszukiwanie w historii (case-insensitive)
- 🏷️ Kategoryzacja elementów (tekst/obraz/plik)
- ⭐ Ulubione elementy (pin)
- 📤 Eksport historii do pliku
- ⚙️ Ustawienia aplikacji (limit, skrót, auto-clear)
- 🌙 Dark mode
- 🔔 Notyfikacje (kopia skopiowana, element przywrócony)

## [2.0.0] - Planned

### Planned Features for v2.0
- ☁️ iCloud synchronizacja historii
- 🔄 Cross-device sync (między Makami)
- 🔐 Szyfrowanie wrażliwych danych
- 🍎 Shortcuts integration
- 📍 Menu Bar app (zawsze widoczne)
- 🧵 Thread-safe clipboard monitoring
- 💾 SQLite storage (zamiast UserDefaults)
- 🎛️ Advanced preferences UI

## Wznowienie dla głównych wersji

### 0.1.0 - Alpha (Internal)
- Podstawowa struktura projektu
- Prototyp monitorowania schowka
- Proof of concept hotkey

### 0.2.0 - Beta
- Stabilne API dla ClipboardService
- Testowanie on macOS
- Bug fixes z alpha

### 1.0.0 - Stable Release
- Wszystkie MVP funkcjonalności
- Pełne dokumentacja
- Ready dla publicznego wydania

---

## Notes

- **Dla deweloperów:** Dodaj swoje zmiany w sekcji "Unreleased" przed każdym release'em
- **Format:** `[X.Y.Z] - YYYY-MM-DD` dla releaseów
- **Kategoryzuj zmiany:** Added, Changed, Deprecated, Removed, Fixed, Security

## Starsze wersje

Brak wersji poprzedzających v1.0.0 (projekt nowy, 2026).

---

**Last Updated:** 2026-01-01  
**Maintainer:** pajlo (pawelmateuszfil@gmail.com)
