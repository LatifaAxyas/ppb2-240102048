import 'package:flutter/material.dart';

import '../main.dart';

/// Halaman Profil: StatelessWidget (UI statis).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String nama = 'Latifa Axyas';
  static const String nim = '240102048';
  static const String prodi = 'Teknik Informatika - UM Bandung';
  static const String email = 'latifaaxyas@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.mint,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 64,
                backgroundColor: AppColors.lavender,
                backgroundImage: AssetImage('assets/foto.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            Text(nama,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text(nim),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.softBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(icon: Icons.school, text: prodi),
                  SizedBox(height: 12),
                  _InfoRow(icon: Icons.email_outlined, text: email),
                  SizedBox(height: 12),
                  _InfoRow(icon: Icons.phone_android, text: 'Pemrograman Perangkat Bergerak'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    );
  }
}
