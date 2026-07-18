
# 🎓 Floreo Quiz App

**A polished, responsive Flutter Web quiz application** — built for the EvolvEd Ventures / Floreo technical assessment.


### 🔗 **Live Demo → https://rashin123786.github.io/quiz_app/


---

## 📖 About

Floreo Quiz presents multiple-choice questions, **locks each answer once selected**, reveals correct ✅ / incorrect ❌ results with an explanation, **persists progress locally**, and **adapts its layout** for mobile and desktop screens.

---

## ✨ Features

| | Feature | Details |
|---|---|---|
| 🔢 | **Question Navigation** | Jump via the Question Number Selector, or step through with Next / Previous |
| 🔒 | **Answer Locking** | Once selected, an answer can't be changed |
| 🟢🔴 | **Result Feedback** | Correct answer highlighted **green**, wrong selection highlighted **red** |
| 💡 | **Explanations** | Shown automatically after each answer |
| 🟣 | **Progress Highlighting** | Answered questions are visually marked in the selector |
| 💾 | **Local Persistence** | Progress saved via `SharedPreferences`, restored on relaunch |
| 📱💻 | **Responsive UI** | Single column on mobile, sidebar layout on desktop |

---

## 🛠️ Tech Stack

| Concern | Package |
|---|---|
| 🧠 State management | `flutter_bloc` / `bloc` |
| 💾 Local storage | `shared_preferences` |
| 💉 Dependency injection | `get_it` |
| 🧭 Routing | `go_router` |
| ⚖️ Value equality | `equatable` |

---

## 🏗️ Architecture

Built with a **Clean Architecture**-inspired structure — `domain`, `data`, and `presentation` layers — so business logic stays independent of UI and storage details.

```
lib/
├── main.dart
├── config/
│   ├── injection/        # 💉 get_it service locator setup
│   └── routes/            # 🧭 go_router route configuration
├── core/
│   ├── constants/         # app-wide constants (storage keys, etc.)
│   ├── theme/              # 🎨 colors, text styles, ThemeData
│   └── utils/              # 📱 responsive layout helpers
├── domain/
│   ├── entities/           # Question entity (pure Dart, no dependencies)
│   ├── repositories/       # abstract repository contracts
│   └── usecases/            # quiz use cases
├── data/
│   ├── datasources/        # 💾 SharedPreferences-backed local data source
│   ├── models/              # data models (JSON-serializable)
│   └── repositories/        # repository implementation
└── presentation/
    ├── blocs/               # 🧠 QuizBloc (events, states, business logic)
    ├── screens/              # QuizScreen, ResultScreen
    └── widgets/              # reusable, single-responsibility UI widgets
```

**Why this structure?**
- 🧩 `domain` has no Flutter or storage imports — quiz logic is easy to unit test in isolation.
- 🔌 `data` implements the repository contract on top of `SharedPreferences`, so storage (e.g. swapping to Hive) can change without touching the BLoc or UI.
- 🗂️ `presentation` splits into `screens` (layout composition) and `widgets` (single-responsibility, reusable pieces), keeping each file focused.

---

## 🧠 State Management

`QuizBloc` is the single source of truth for quiz state:

- **States:** `QuizLoading` · `QuizLoaded` · `QuizError`
- **Events:** `QuizAnswerSelected` · `QuizQuestionChanged`

Every answer selection or navigation change is persisted through the repository, so a page refresh resumes exactly where the user left off.

---

## 📱 Responsive Design

A `ResponsiveLayout` widget + `context.responsive(...)` extension (`core/utils/responsive.dart`) drives breakpoint-based layout:

| Breakpoint | Layout |
|---|---|
| `< 600px` 📱 | Mobile — single scrollable column |
| `600–1024px` 📟 | Tablet — falls back to mobile layout |
| `≥ 1024px` 💻 | Desktop — sidebar (question grid + legend) + main content |

Font sizes and spacing scale per breakpoint via `context.rfs()` / `context.responsive()` — no duplicated layout code.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.10.0` (Dart `>=3.0.0`)
- Chrome (for local web development/debugging)

### Setup

```bash
# 1️⃣ Clone the repository
git clone https://github.com/rashin123786/quiz_app.git
cd quiz_app

# 2️⃣ Install dependencies
flutter pub get

# 3️⃣ Run on Chrome (development)
flutter run -d chrome

# 4️⃣ Build for production
flutter build web
```

Production output lands in `build/web/`, deployable to any static host (GitHub Pages, Firebase Hosting, Netlify, Vercel, etc.).

### 🧪 Running Tests

```bash
flutter test
```

---

## ☁️ Deployment

Deployed to **GitHub Pages** → **[rashin123786.github.io/quiz_app](https://rashin123786.github.io/quiz_app/)**


```bash
flutter build web --release --base-href /quiz_app/
```

The build output is pushed to the `gh-pages` branch and served from there. ✅

---

## 📝 Project Notes

- Quiz questions are currently seeded locally (`data/datasources`); swapping in a remote API only needs a new `QuizRemoteDataSource` behind the existing `QuizRepository` contract.
- Progress is stored as JSON in `SharedPreferences` under keys defined in `core/constants/app_constants.dart`, cleared on reset/completion.

---


## 👤 Author

Submitted by **Rashin.k** for the Flutter Web Technical Assessment — EvolvEd Ventures · Floreo

</div>
