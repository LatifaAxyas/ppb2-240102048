# PPB Praktikum 2 — Dasar Dart, Widget Tree & Layout Flutter

Aplikasi 2 halaman:
- **Profil** (`StatelessWidget`) — Container + Column + Text.
- **Daftar Mahasiswa** (`StatefulWidget`) — `FutureBuilder` + `ListView.builder` dari `https://jsonplaceholder.typicode.com/users`, pull-to-refresh, SnackBar saat error.

Tema pastel: biru `#A8D8FF`, peach `#FFD6B3`, mint `#B9E5D3`.

## Struktur
```
lib/
  main.dart                  # tema + navigasi
  models/user.dart           # User.fromJson (null safe)
  services/api_service.dart  # logic HTTP
  screens/profile_screen.dart
  screens/list_screen.dart
```

## Cara menjalankan
```bash
flutter create .      # sekali saja, untuk generate folder android/ios/web
flutter pub get
flutter run
```

## Screenshot
<img width="298" height="374" alt="Profil" src="https://github.com/user-attachments/assets/3cb0fda8-c33b-4d68-bff6-027b087abdfe" />
<img width="298" height="374" alt="list" src="https://github.com/user-attachments/assets/5b85e094-692c-4584-80c3-3f177a8ca4a7" />

