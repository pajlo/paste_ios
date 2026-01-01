# Paste - macOS Clipboard History Manager

![macOS](https://img.shields.io/badge/macOS-12.0+-blue)
![Swift](https://img.shields.io/badge/Swift-5.5+-orange)
![License](https://img.shields.io/badge/License-MIT-green)

## O Aplikacji

Paste to elegancka i lekka aplikacja macOS, która zapamiętuje Twoją historię schowka. Szybko przywołaj ostatnie 10 skopiowanych elementów za pomocą skrótu **cmd+shift+v**.

## Cechy

- ✅ **Monitorowanie schowka w czasie rzeczywistym** - automatycznie zapisuje wszystkie kopie
- ✅ **Historia do 10 elementów** - zawsze dostępna najnowsza zawartość
- ✅ **Globalny skrót** - cmd+shift+v działa wszędzie
- ✅ **Szybki dostęp** - natychmiast skopiuj element z historii
- ✅ **Lekka aplikacja** - minimalny wpływ na system
- ✅ **Lokalne przechowywanie** - pełna kontrola nad danymi

## Instalacja

### Wymagania
- macOS 12.0 (Monterey) lub nowsze
- Xcode 13.0+

### Budowanie z kodu

```bash
git clone https://github.com/yourusername/Paste.git
cd Paste
open Paste.xcodeproj
```

W Xcode:
1. Wybierz target `Paste`
2. Naciśnij **Cmd+B** aby zbudować
3. Naciśnij **Cmd+R** aby uruchomić aplikację

## Użytkowanie

1. **Uruchom aplikację** - pojawi się w docku
2. **Kopuj jak zwykle** - aplikacja automatycznie zapisuje
3. **Wywołaj historię** - naciśnij **cmd+shift+v**
4. **Kliknij element** - aby go skopiować do schowka

## Architektura

```
Paste/
├── Models/
│   └── ClipboardItem.swift        # Model danych elementu
├── Services/
│   ├── ClipboardService.swift     # Monitorowanie schowka
│   ├── HistoryManager.swift       # Zarządzanie historią
│   └── HotKeyManager.swift        # Obsługa skrótu
├── Views/
│   ├── ContentView.swift          # Główny widok
│   ├── HistoryListView.swift      # Lista historii
│   └── ClipboardItemRow.swift     # Wiersz elementu
├── Utils/
│   └── Constants.swift            # Stałe aplikacji
└── PasteApp.swift                # Punkt wejścia
```

## Struktura projektu

- **Models**: Struktur danych aplikacji
- **Services**: Logika biznesowa (monitorowanie, zarządzanie)
- **Views**: Interfejs użytkownika (SwiftUI)
- **Utils**: Narzędzia i stałe

## Konfiguracja

Historia przechowywana jest lokalnie w UserDefaults. W przyszłości plan na:
- [ ] Synchronizacja z iCloud
- [ ] Export/Import historii
- [ ] Obsługa obrazów w schowku
- [ ] Kategoryzacja elementów

## Bezpieczeństwo

Aplikacja żąda dostępu do schowka systemowego. Wszystkie dane przechowywane są lokalnie na Twoim urządzeniu.

## Licencja

MIT License - zobacz LICENSE.md

## Roadmap

- [x] Konfiguracja projektu
- [ ] Implementacja ClipboardService
- [ ] Implementacja HistoryManager
- [ ] Rejestracja globalnego skrótu
- [ ] Interfejs użytkownika
- [ ] Testy jednostkowe
- [ ] Release 1.0

## Wsparcie

Jeśli napotkasz problem, utwórz issue na GitHubie.

## Autor

Stworzone dla maksymalnej produktywności na macOS ⚡
