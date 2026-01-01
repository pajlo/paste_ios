# Product Requirements Document (PRD) - Paste

## 1. Wstęp
Paste to natywna aplikacja macOS, która zapamiętuje historię schowka i umożliwia szybki dostęp do ostatnio skopiowanych elementów za pośrednictwem globalnego skrótu klawiszowego.

## 2. Cel produktu
Zwiększenie produktywności użytkownika poprzez:
- Automatyczne zapamiętywanie skopiowanych danych
- Szybki dostęp do historii schowka (cmd+shift+v)
- Przechowywanie ostatnich 10 elementów

## 3. Wymagania funkcjonalne

### 3.1 Monitorowanie schowka
- Aplikacja monitoruje systemowy schowek (NSPasteboard) w czasie rzeczywistym
- Automatycznie zapisuje każdą nową zawartość schowka
- Obsługuje tekst i inne wspierane typy danych

### 3.2 Historia schowka
- Przechowuje do 10 ostatnio skopiowanych elementów
- Każdy element zawiera:
  - Zawartość (tekst)
  - Timestamp (data i godzina kopiowania)
  - Typ danych (tekst, URL, obraz - w przyszłości)
- Elementy są sortowane chronologicznie (najnowszy na górze)

### 3.3 Globalny skrót klawiszowy
- **Skrót**: `cmd+shift+v`
- Wywoła okno z historią schowka niezależnie od aktywnej aplikacji
- Umożliwia szybkie przełączenie i widok całej historii

### 3.4 Interfejs użytkownika
- Okno z listą elementów historii
- Każdy element wyświetla:
  - Podgląd zawartości (pierwsze 100 znaków)
  - Czas kopiowania
- Możliwość kliknięcia aby skopiować element z powrotem do schowka
- Wyswietl zapamiętane elementy w przejrzystej liście
- Usuwanie elementów z historii

### 3.5 Trwałość danych
- Dane są zapisywane lokalnie (UserDefaults lub pliki JSON)
- Opcjonalna synchronizacja z iCloud (w przyszłości)

## 4. Wymagania niefunkcjonalne

### 4.1 Wydajność
- Monitorowanie schowka z minimalnym wpływem na zasoby
- Pobieranie historii powinno być natychmiastowe

### 4.2 Bezpieczeństwo
- Dostęp do schowka wymaga uprawnień na macOS
- Dane przechowywane bezpiecznie (nie w plaintext bez potrzeby)

### 4.3 Kompatybilność
- macOS 12.0+ (Monterey lub nowsze)
- Apple Silicon i Intel

## 5. Architektura

### 5.1 Komponenty
- **ClipboardService**: Monitoruje zmiany w schowku
- **ClipboardModel**: Reprezentacja pojedynczego elementu historii
- **HistoryManager**: Zarządza przechowywaniem i pobieraniem historii
- **GlobalHotKeyManager**: Obsługuje rejestrację i nasłuchiwanie skrótu
- **ContentView**: Główny interfejs użytkownika

### 5.2 Struktura danych
```swift
struct ClipboardItem: Codable, Identifiable {
    let id: UUID
    let content: String
    let timestamp: Date
    let type: ClipboardType
}
```

## 6. Harmonogram implementacji
- Faza 1: Konfiguracja projektu Xcode i struktura
- Faza 2: Implementacja ClipboardService
- Faza 3: Implementacja HistoryManager
- Faza 4: Obsługa globalnego skrótu
- Faza 5: Interfejs użytkownika
- Faza 6: Testy i publikacja

## 7. Metryki sukcesu
- Aplikacja uruchamia się bez błędów
- Skrót cmd+shift+v działa globalnie
- Historia zapisuje i wczytuje dane poprawnie
- Maksymalnie 10 elementów przechowywanych
