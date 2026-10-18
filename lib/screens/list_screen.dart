import 'package:flutter/material.dart';

import '../main.dart';
import '../models/user.dart';
import '../services/api_service.dart';

/// Halaman Daftar Mahasiswa: StatefulWidget + FutureBuilder.
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ApiService _service = ApiService();
  late Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    // Future disimpan di field, BUKAN dipanggil di build().
    _users = _load();
  }

  /// Ambil data; jika gagal tampilkan SnackBar lalu lempar ulang
  /// agar FutureBuilder bisa menampilkan snapshot.hasError.
  Future<List<User>> _load() async {
    try {
      return await _service.fetchUsers();
    } catch (e) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal load — cek koneksi'),
              backgroundColor: AppColors.peach,
              behavior: SnackBarBehavior.floating,
            ),
          );
        });
      }
      rethrow;
    }
  }

  Future<void> _refresh() async {
    final next = _load();
    setState(() => _users = next);
    try {
      await next; // RefreshIndicator menunggu sampai selesai
    } catch (_) {
      // error sudah ditangani (SnackBar + tampilan error)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Mahasiswa')),
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _ErrorView(onRetry: _refresh);
          }
          final users = snapshot.data ?? const <User>[];
          return RefreshIndicator(
            color: Colors.black87,
            backgroundColor: AppColors.peach,
            onRefresh: _refresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: users.length,
              itemBuilder: (context, i) => _UserCard(user: users[i]),
            ),
          );
        },
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.softBlue,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.mint,
              child: Text(
                user.name.isEmpty ? '?' : user.name[0],
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(user.email),
                  Text('${user.company} • ${user.city}',
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off, size: 56, color: Colors.black45),
          const SizedBox(height: 12),
          const Text('Gagal load — cek koneksi'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Coba lagi')),
        ],
      ),
    );
  }
}
