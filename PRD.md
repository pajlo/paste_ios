# Product Requirements Document (PRD) - Paste

## 1. Przegląd produktu

**Nazwa:** Paste  
**Platforma:** macOS 12.0+  
**Typ:** Menu Bar Application + Global Hotkey App  
**Cel:** Uprości dostęp do historii schowka poprzez globalny skrót

## 2. Problem i motywacja

Użytkownicy macOS często potrzebują dostępu do wcześniej skopiowanego tekstu lub obrazów. Domyślnie system macOS nie oferuje wbudowanego menedżera historii schowka, zmuszając użytkowników do kopiowania zawartości wiele razy lub korzystania z drag-and-drop.

## 3. Cele produktu

- Automatycznie zapisywać ostatnie 10 elementów schowka
- Udostępnić szybki dostęp przez skrót `Cmd+Shift+V`
- Wyświetlać metadane (czas, typ) dla każdego elementu
- Umożliwić wyszukiwanie w historii
- Zapewnić niezawodne działanie w tle

## 4. Użytkownik docelowy

- Profesjonaliści (programiści, copywriterzy, projektanci)
- Power users macOS
- Osoby pracujące z dużą ilością tekstu/obrazów
- Wiek: 18-65 lat

## 5. Specyfikacja funkcjonalna

### 5.1 Główne funkcjonalności

#### Funkcja 1: Monitorowanie schowka
- **Opis:** Aplikacja monitoruje systemowy schowak w tle
- **Trigger:** Zmiana zawartości schowka
- **Akcja:** Zapisz nowy element do historii z timestampem
- **Ograniczenia:** Maksymalnie 10 ostatnich elementów

#### Funkcja 2: Interfejs historii
- **Opis:** Wyświetla listę ostatnich elementów schowka
- **UI:** SwiftUI - lista z przewijaniem
- **Informacje:** Zawartość (preview), timestamp, typ (tekst/obraz/plik)
- **Akcje:** Kliknięcie = kopiuj do schowka, X = usuń z historii

#### Funkcja 3: Globalny skrót
- **Skrót:** `Cmd+Shift+V`
- **Akcja:** Pokaż/ukryj okno historii
- **Implementacja:** EventTap lub NSEvent monitoring
- **Zachowanie:** Okno zawsze na wierzchu, wyśrodkowane

#### Funkcja 4: Persistence
- **Przechowywanie:** UserDefaults (domyślnie) lub iCloud (opcjonalnie)
- **Format:** JSON array ClipboardItem
- **Przywracanie:** Ładowanie historii przy starcie aplikacji

### 5.2 Interfejs użytkownika

#### Ekran główny (History List)
```
┌─────────────────────────────────────────┐
│ Paste - Historia schowka          [x]   │
├─────────────────────────────────────────┤
│ 🔍 Szukaj...                            │
├─────────────────────────────────────────┤
│ [1]  "Some copied text..." 14:32  [x]   │
│ [2]  [Obraz 640x480] 14:25        [x]   │
│ [3]  "filename.pdf" (Plik) 14:15  [x]   │
│ [4]  "..." 14:00                   [x]   │
│ ...                                     │
└─────────────────────────────────────────┘
```

### 5.3 Przepływ użytkownika

1. Użytkownik kopuje tekst (Cmd+C)
2. Aplikacja detektuje zmianę schowka
3. Element dodawany do historii (max 10)
4. Użytkownik naciska Cmd+Shift+V
5. Okno z historią się pojawia
6. Klikając element - zawartość wraca do schowka
7. Okno zamyka się (opcjonalnie) i użytkownik może wkleić

## 6. Niefunkcjonalne wymagania

### Wydajność
- Czas otworzenia okna: < 500ms
- Memory footprint: < 50MB
- Monitorowanie schowka: < 5% CPU

### Bezpieczeństwo
- Dane przechowywane lokalnie na dysku użytkownika
- Brak wysyłania danych na serwery (domyślnie)
- Uprawnienia: Accessibility (do globalnego hotkey)

### Niezawodność
- Automatyczne restartowanie monitorowania po krachu
- Graceful handling błędów odczytu schowka
- Limity rozmiaru: Max 10 elementów, max 5MB na element

### Kompatybilność
- macOS 12.0 (Monterey) +
- Intel i Apple Silicon Macs

## 7. Ograniczenia i założenia

- **Ograniczenie:** Brak synchronizacji między urządzeniami (domyślnie)
- **Ograniczenie:** Brak szyfrowania danych historii
- **Założenie:** Użytkownik ma dostęp do menu Accessibility
- **Założenie:** Użytkownik akceptuje przechowywanie danych lokalnie

## 8. MVP (Minimum Viable Product)

### Faza 1 (Wersja 1.0)
- [x] Monitorowanie schowka
- [x] Historia (max 10 elementów)
- [x] Globalny hotkey Cmd+Shift+V
- [x] Interfejs listy
- [x] Kopiowanie elementu z historii
- [x] Usuwanie elementu z historii
- [x] Persistence (UserDefaults)

### Faza 2 (Wersja 1.1)
- [ ] Wyszukiwanie w historii
- [ ] Kategoryzacja (tekst/obraz/plik)
- [ ] Pin ulubionego elementu
- [ ] Eksport historii

### Faza 3 (Wersja 2.0)
- [ ] iCloud Sync
- [ ] Cross-device sync
- [ ] Shortcuts integration
- [ ] Menu bar droplet

## 9. Kryteria akceptacji

- ✅ Aplikacja się uruchamia bez błędów
- ✅ Monitorowanie schowka działa w tle
- ✅ Cmd+Shift+V otwiera interfejs historii
- ✅ Historia wyświetla ostatnie 10 elementów
- ✅ Kliknięcie przywraca zawartość do schowka
- ✅ Usunięcie usuwa z historii i UserDefaults
- ✅ Historia persystuje po restarcie aplikacji
- ✅ Brak crash'ów przy regularnym użytkowaniu
- ✅ Memory usage stable poniżej 50MB

## 10. Timeline

- **Tydzień 1:** Konfiguracja projektu, modele, services
- **Tydzień 2:** UI, hotkey integration
- **Tydzień 3:** Testowanie, debugowanie, release 1.0
