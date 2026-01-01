# Setup Instructions - Paste

## Kroki instalacji

### 1. Wymagania wstępne

Upewnij się, że masz zainstalowane:
- **macOS 12.0 (Monterey)** lub nowszej
- **Xcode 14.0** lub nowsze (zawiera Swift 5.7+)
- **Git** (do klonowania repozytorium)

Sprawdzenie wersji:
```bash
sw_vers                    # macOS version
xcode-select --print-path  # Xcode path
git --version              # Git version
```

### 2. Klonowanie repozytorium

```bash
# Wybierz katalog gdzie chcesz przechowywać projekt
mkdir -p ~/Projects
cd ~/Projects

# Sklonuj repozytorium
git clone <repo-url> Paste_ios
cd Paste_ios
```

### 3. Otwieranie projektu w Xcode

```bash
# Z poziomu katalogu projektu
open Paste/Paste.xcodeproj
```

Alternatywnie:
1. Otwórz Xcode
2. File → Open
3. Przejdź do `Paste_ios/Paste/` i wybierz plik projektu

### 4. Konfiguracja projektu

#### 4.1 Signing & Capabilities
1. Otwórz projekt w Xcode
2. Kliknij na "Paste" w Project Navigator (lewej stronie)
3. Wybierz target "Paste"
4. Przejdź do zakładki "Signing & Capabilities"
5. Wybierz Team (Your ID)
6. Bundle Identifier powinien być: `com.pajlo.paste` (lub dostosuj)

#### 4.2 Uprawnienia (Entitlements)
1. W zakładce "Signing & Capabilities" kliknij "+ Capability"
2. Dodaj:
   - **App Sandbox** (jeśli dystrybucja przez App Store)
   - Lub pozostaw bez, jeśli lokalna instalacja

#### 4.3 Info.plist
Sprawdź czy zawiera:
```xml
<key>NSAccessibilityUsageDescription</key>
<string>Aplikacja Paste potrzebuje dostępu do funkcji Accessibility aby obsługiwać globalny skrót Cmd+Shift+V</string>

<key>LSUIElement</key>
<true/>
```

### 5. Build & Run

#### 5.1 Build
```bash
# Z Xcode
- Naciśnij Cmd+B aby zbudować projekt
```

Lub z terminala:
```bash
xcodebuild -scheme Paste -configuration Debug
```

#### 5.2 Run
```bash
# Z Xcode
- Naciśnij Cmd+R aby uruchomić aplikację
```

Lub z terminala:
```bash
xcodebuild -scheme Paste -configuration Debug -derivedDataPath ./build
./build/Build/Products/Debug/Paste.app/Contents/MacOS/Paste
```

### 6. Uprawnienia Accessibility (ważne!)

Po pierwszym uruchomieniu aplikacji:

1. Otwórz **System Settings** (Ustawienia systemowe)
2. Przejdź do **Privacy & Security** → **Accessibility**
3. Kliknij "+" (plus) aby dodać aplikację
4. Przejdź do folderu budowania: `./build/Build/Products/Debug/`
5. Wybierz `Paste.app`
6. Kliknij **Open**
7. Potwierdź wybór

**Alternatywa (terminal):**
```bash
# Dodaj uprawnienia accessibility (jeśli trzeba)
sqlite3 ~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.apple.accessibility.MRU.sfl2

# Lub ręcznie przez ustawienia systemowe
```

### 7. Testowanie

Po uruchomieniu aplikacji:

1. **Test 1: Monitorowanie schowka**
   - Skopiuj tekst (Cmd+C) z dowolnego programu
   - Sprawdź czy pojawia się w oknie Paste

2. **Test 2: Globalny hotkey**
   - Naciśnij **Cmd+Shift+V**
   - Okno historii powinno się pojawić

3. **Test 3: Kopiowanie z historii**
   - Kliknij na element z historii
   - Wklej (Cmd+V) w innym programie
   - Powinna być tam prawidłowa zawartość

4. **Test 4: Usuwanie**
   - Kliknij "X" obok elementu
   - Element powinien zniknąć

5. **Test 5: Persistence**
   - Zamknij aplikację
   - Uruchom ją ponownie
   - Historia powinna być zachowana

### 8. Konfiguracja dodatkowa (opcjonalnie)

#### 8.1 Zmiana skrótu klawiszowego
1. Otwórz `Paste/Utils/Constants.swift`
2. Zmień wartość `Config.hotKeyCode` lub `Config.hotKeyModifiers`
3. Rebuild (Cmd+B)

#### 8.2 Zmiana limitu historii
1. Otwórz `Paste/Utils/Constants.swift`
2. Zmień wartość `Config.maxHistoryItems`
3. Rebuild

#### 8.3 Reset danych
```bash
# Wyczyść historię
defaults delete com.pajlo.paste.history

# Wyczyść wszystkie preferencje aplikacji
defaults delete com.pajlo.paste

# Lub przez Terminal
rm ~/Library/Preferences/com.pajlo.paste.plist
```

### 9. Dystrybucja

#### 9.1 Lokalna instalacja

```bash
# Build release version
xcodebuild -scheme Paste -configuration Release

# Skopiuj aplikację do Applications
cp -r ./build/Build/Products/Release/Paste.app ~/Applications/
```

#### 9.2 App Store (wymagane Developer Account)
```bash
# Przygotuj archive
xcodebuild -scheme Paste -configuration Release \
  -archivePath ./build/Paste.xcarchive archive

# Exportuj dla App Store
xcodebuild -exportArchive \
  -archivePath ./build/Paste.xcarchive \
  -exportPath ./build/Paste.ipa \
  -exportOptionsPlist ./Scripts/ExportOptions.plist
```

### 10. Troubleshooting

#### Problem: "App can't be opened because it is from an unidentified developer"
```bash
# Rozwiązanie: Usuń extended attributes
xattr -rd com.apple.quarantine ~/Applications/Paste.app

# Lub otwórz z Ctrl+click i pozwól na uruchomienie
```

#### Problem: "Accessibility permissions not working"
1. Usuń aplikację z Accessibility list
2. Spróbuj ponownie dodać
3. Uruchom ponownie aplikację

#### Problem: Hotkey nie działa
1. Sprawdź czy aplikacja ma uprawnienia Accessibility
2. Sprawdź czy żadna inna aplikacja nie używa Cmd+Shift+V
3. Sprawdź logi: `log stream --predicate 'process == "Paste"'`

#### Problem: Historia nie zapisuje się
```bash
# Sprawdź czy jest dostęp do UserDefaults
defaults read com.pajlo.paste.history

# Wyczyść i spróbuj ponownie
defaults delete com.pajlo.paste.history
```

### 11. Zasoby techniczne

- [Apple macOS App Development](https://developer.apple.com/documentation/macos)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Xcode Help](https://help.apple.com/xcode/)
- [Git Documentation](https://git-scm.com/doc)

### 12. Support

Jeśli napotkacie problemy:
1. Sprawdzicie DEVELOPMENT_GUIDE.md
2. Sprawdzite logi w Xcode (Ctrl+Cmd+Y aby pokazać logi)
3. Otwórz issue na GitHubie z opisem problemu
4. Kontakt: pawelmateuszfil@gmail.com

---

**Ostatnia aktualizacja:** Styczeń 2026  
**Wersja:** 1.0-beta
