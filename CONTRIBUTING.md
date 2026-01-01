# Contributing to Paste

Dziękujemy za zainteresowanie udziałem w projekcie Paste! 🙏

## Kod postępowania

Będziesz miłym i szanującym do wszystkich kontrybutorów. Nietolerancja w stosunku do rasizmu, seksizmu, homofobii lub dyskryminacji.

## Jak przyczynić się do projektu

### 1. Reportowanie błędów

Jeśli znaleźliście bug:
1. Sprawdzić czy bug nie został już zgłoszony
2. Utworzyć issue z:
   - Opisem problemu
   - Krokami do reprodukcji
   - Oczekiwanym zachowaniem
   - Aktualnym zachowaniem
   - Wersją macOS i Xcode
   - Screenshots (jeśli dotyczy UI)

**Szablon:**
```
## Opis problemu
[Krótki opis]

## Kroki do reprodukcji
1. [Krok 1]
2. [Krok 2]
3. [Krok 3]

## Oczekiwane zachowanie
[Co powinno się stać]

## Aktualne zachowanie
[Co się dzieje]

## Środowisko
- macOS: [wersja]
- Xcode: [wersja]
- Paste: [wersja/commit]
```

### 2. Sugestie funkcjonalności

Masz pomysł na nową funkcję? Świetnie!
1. Utwórz issue z labelą `enhancement`
2. Opisz funkcję i dlaczego byłaby przydatna
3. Dodaj example use case

### 3. Pull Requests

#### 3.1 Fork i branch
```bash
# Fork repo na GitHubie
# Clone fork'a
git clone https://github.com/YOUR_USERNAME/Paste_ios.git
cd Paste_ios

# Utwórz feature branch
git checkout -b feature/my-awesome-feature
# lub bugfix
git checkout -b bugfix/issue-description
```

#### 3.2 Zmiany
- **Jedno rozwiązanie na PR** - jeden problem = jeden PR
- **Testy** - dodaj testy dla nowych funkcjonalności
- **Dokumentacja** - update README/docs jeśli trzeba
- **Code style** - patrz DEVELOPMENT_GUIDE.md

#### 3.3 Commit messages
```
<type>(<scope>): <subject>

<body>

Fixes #<issue>
```

**Types:**
- `feat` - nowa funkcjonalność
- `fix` - poprawka błędu
- `docs` - dokumentacja
- `style` - formatting (bez logiki)
- `refactor` - zmiana kodu bez nowych features
- `test` - testy
- `chore` - build, deps, tooling

**Scopes:**
- `history` - HistoryManager
- `clipboard` - ClipboardService
- `hotkey` - HotKeyManager
- `ui` - Views
- `models` - Models
- `docs` - Dokumentacja

**Przykład:**
```
feat(history): add search functionality

- Implement case-insensitive search
- Real-time filtering
- Highlight matching text

Fixes #15
```

#### 3.4 Push i Pull Request
```bash
# Push na fork
git push origin feature/my-awesome-feature

# Na GitHubie: Create Pull Request
# Fill in PR template:
# - Description of changes
# - Fixes #<issue>
# - Testing done
```

**PR Template:**
```markdown
## Description
[Opisz zmiany]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added
- [ ] Manual testing done
- [ ] Tested on macOS [version]

## Checklist
- [ ] Code follows style guidelines
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No breaking changes

Fixes #<issue>
```

### 4. Review Process

Maintainer (pajlo) will:
1. Sprawdzić czy PR jest kompletny
2. Przejrzeć kod (code review)
3. Poprosić o zmiany jeśli trzeba
4. Merge i close issue

### 5. Development Setup

```bash
# Clone
git clone https://github.com/pajlo/Paste_ios.git
cd Paste_ios

# Configure Git
git config user.name "Your Name"
git config user.email "you@example.com"

# Open in Xcode
open Paste/Paste.xcodeproj
```

## Style Guide

### Swift Code Style

```swift
// Indentation: 4 spaces
func example() {
    let variable = "value"
}

// Naming conventions
class MyClass { }           // PascalCase
struct MyStruct { }
enum MyEnum { }
func myFunction() { }       // camelCase
let myVariable = "value"
var mutableVariable = ""

// Constants
struct Constants {
    static let MAX_ITEMS = 10  // UPPER_SNAKE_CASE
}

// Access control (explicit)
public class MyClass { }
private func helper() { }
internal var internalVar = ""

// Comments
/// Documentation comment (used for symbol docs)
func documented() { }

// single line comment
var x = 0

// MARK: - Section separator
// MARK: Public Methods
```

### SwiftUI Views

```swift
struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    ItemRow(item: item)
                }
            }
            .navigationTitle("Title")
        }
    }
}

#Preview {
    ContentView()
}
```

## Testing

```bash
# Run tests
xcodebuild test -scheme Paste

# Or in Xcode: Cmd+U
```

**Test guidelines:**
- Test names describe what they test: `testAddItemIncrementsCount()`
- Use descriptive assertions
- Mock external dependencies
- Arrange-Act-Assert pattern

```swift
func testHistoryLimitTo10Items() {
    // Arrange
    let manager = HistoryManager()
    let items = (0..<15).map { ClipboardItem(...) }
    
    // Act
    items.forEach { manager.addItem($0) }
    
    // Assert
    XCTAssertEqual(manager.getHistory().count, 10)
}
```

## Documentation

- Update README.md dla user-facing changes
- Update DEVELOPMENT_GUIDE.md dla developer docs
- Add code comments dla complex logic
- Update CHANGELOG.md w każdym PR

## Questions?

- Email: pawelmateuszfil@gmail.com
- Open discussion issue

## License

Przez contribution, zgadzasz się że Twój kod będzie pod MIT License.

---

**Happy coding!** 🚀

Dziękujemy za wkład w Paste!
