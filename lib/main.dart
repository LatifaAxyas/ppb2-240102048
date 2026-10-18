import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/list_screen.dart';
import 'screens/profile_screen.dart';

/// Palet pastel sesuai ketentuan tugas.
class AppColors {
  static const blue = Color(0xFFA8D8FF); // primary: AppBar / Card
  static const peach = Color(0xFFFFD6B3); // secondary: button / loading
  static const mint = Color(0xFFB9E5D3); // accent
  static const lavender = Color(0xFFE8D8FF);
  static const softBlue = Color(0x59A8D8FF); // blue 35%
  static const surface = Color(0xFFFFFEFB);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPB Praktikum 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blue,
          brightness: Brightness.light,
          surface: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.surface,
        textTheme: GoogleFonts.manropeTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.black87,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.peach,
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: AppColors.peach),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: AppColors.lavender,
          indicatorColor: AppColors.mint,
        ),
      ),
      home: const HomeShell(),
    );
  }
}

/// Kerangka navigasi 2 halaman: Profil (Stateless) & Daftar Mahasiswa (Stateful).
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _pages = <Widget>[ProfileScreen(), ListScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.people_outline), label: 'Mahasiswa'),
        ],
      ),
    );
  }
}
