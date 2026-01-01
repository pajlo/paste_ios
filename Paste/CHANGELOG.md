# Changelog

Wszystkie zmiany w tym projekcie będą dokumentowane w tym pliku.

## Wersje

### [0.1.0] - 2025-01-01

#### Dodane (Added)
- Inicjalna struktura projektu
- Model `ClipboardItem` do reprezentacji elementów historii
- `HistoryManager` do zarządzania historią schowka
- `ClipboardService` do monitorowania zmian w schowku
- `HotKeyManager` do obsługi globalnego skrótu `cmd+shift+v`
- Interfejs użytkownika w SwiftUI
- Obsługa menu bar
- Wyszukiwanie w historii
- Przechowywanie do 10 ostatnich elementów

#### Planowane (Planned)
- [ ] Synchronizacja z iCloud
- [ ] Obsługa obrazów w schowku
- [ ] Kategorzacja elementów
- [ ] Preferencje użytkownika
- [ ] Ciemny motyw
- [ ] Testy jednostkowe

## Workflow versjonowania

Projekt stosuje [Semantic Versioning](https://semver.org/):
- **MAJOR**: Zmiany niezgodne wstecz
- **MINOR**: Nowe funkcje, wstecz kompatybilne
- **PATCH**: Poprawki błędów

Tagowanie: `git tag -a v0.1.0 -m "Initial release"`
