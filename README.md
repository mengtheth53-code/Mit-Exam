# 🎮 GamerPower Giveaways App

A modern Flutter application built for the Individual Assignment that fetches and displays active gaming giveaways from the [GamerPower API](https://www.gamerpower.com/api/giveaways).

---

## 🌟 Assignment Requirements Checklist

| Requirement | Implementation Details | Status |
| :--- | :--- | :---: |
| **1. Use Riverpod** | Powered by `flutter_riverpod` (v3.x) using `FutureProvider` and `NotifierProvider` | ✅ |
| **2. Bottom Navigation Bar** | Material 3 `NavigationBar` with `IndexedStack` for seamless tab switching | ✅ |
| **3. Game Screen** | Responsive `GridView.builder`, search query filtering, platform filter chips, pull-to-refresh | ✅ |
| **4. Detail Screen** | Full giveaway breakdown (hero image, worth badges, platforms, claim guide, and direct browser launcher) | ✅ |
| **5. Settings Screen** | Dedicated settings tab with: | ✅ |
| ↳ **5.1 Dark Mode Switching** | `System Default`, `Light Mode`, and `Dark Mode` toggles | ✅ |
| ↳ **5.2 Color Theme Switching** | Dynamic seed color palette (7 color swatches with instant app-wide theme change) | ✅ |

---

## 🏗️ Project Architecture & Folder Structure

```
lib/
├── main.dart                          # App entry point, ProviderScope, dynamic theme configuration
├── models/
│   └── giveaway.dart                  # GamerPower Giveaway data model with JSON serialization
├── services/
│   └── api_service.dart               # HTTP client fetching from GamerPower API
├── providers/
│   ├── giveaway_provider.dart         # FutureProvider and Notifiers for search & filtering
│   └── theme_provider.dart            # ThemeMode & Seed Color Notifier with Riverpod
├── screens/
│   ├── main_navigation_screen.dart    # Bottom Navigation Bar host
│   ├── games_grid_screen.dart         # GridView of free games with search & filter chips
│   ├── giveaway_detail_screen.dart    # Detail screen with instructions & external claim button
│   └── settings_screen.dart           # Dark mode switcher & color theme selector
└── widgets/
    └── giveaway_card.dart             # Responsive Material 3 giveaway card widget
```

---

## 🚀 How to Run the Project Locally

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed (version 3.19+ / 3.47+)
- Chrome / Edge (for Web) or Android Studio / Emulator (for Mobile)

### Steps
1. **Clone repository:**
   ```bash
   git clone <YOUR_GITHUB_REPOSITORY_URL>
   cd magical-shannon
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on Chrome / Web:**
   ```bash
   flutter run -d chrome
   ```

4. **Run on Android Emulator / Physical Device:**
   ```bash
   flutter run -d android
   ```

5. **Run Tests:**
   ```bash
   flutter test
   ```

---

## 🌐 How to Deploy Your Demo App & Submit

### Option 1: GitHub Pages (Recommended - 100% Free)
1. Build the web release:
   ```bash
   flutter build web --release --base-href "/<REPO_NAME>/"
   ```
2. Deploy the `build/web` folder to the `gh-pages` branch using GitHub Actions or:
   ```bash
   git branch -D gh-pages
   git checkout -b gh-pages
   git add -f build/web
   git commit -m "Deploy web demo"
   git subtree push --prefix build/web origin gh-pages
   ```
3. Your demo link will be: `https://<YOUR_USERNAME>.github.io/<REPO_NAME>/`

### Option 2: Vercel / Netlify / Firebase Hosting (Drag and Drop)
1. Run `flutter build web --release`
2. Go to [Vercel](https://vercel.com) or [Netlify Drop](https://app.netlify.com/drop)
3. Drag and drop the `build/web` folder!
4. You get an instant HTTPS URL (e.g., `https://gamerpower-demo.vercel.app`)

---

## 📝 Submission Links Template

- **Demo App Link**: `https://<your-username>.github.io/<repo-name>/` (or Vercel / Netlify link)
- **Source Code Link**: `https://github.com/<your-username>/<repo-name>`
