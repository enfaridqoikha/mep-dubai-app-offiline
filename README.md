# MEP Dubai App — Offline Quiz (DEWA-style, DBC 2021)

This is a **complete Flutter project** that builds an **offline** MEP quiz app:
- Multiple-choice exam simulator (Electrical, Mechanical, Plumbing)
- Randomized questions and answer order
- Parameterized "calculation" questions (fresh numbers every run)
- Dynamic theme: light/dark + accent color
- No backend needed

## Build with GitHub Actions (no coding)
1. Create a **new empty GitHub repo** (no README).
2. Upload **all files/folders** from this ZIP at the repo root (keep the `.github` folder name).
3. Open **Actions** → run **Build Flutter APK**.
4. Download artifact → `app-release.apk`.

## If NDK mismatch appears
Add inside `android {}` of `android/app/build.gradle(.kts)`:
```
ndkVersion "27.0.12077973"
```

## Local build (optional)
```
flutter create . --platforms=android
flutter pub get
# (if needed) edit android/app/build.gradle to set ndkVersion above
flutter build apk --release
```
