import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

/// Logic HTTP dipisah dari UI (services/).
class ApiService {
  static const apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 3));

    final res = await http
        .get(Uri.parse(apiUrl))
        .timeout(const Duration(seconds: 10));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List<dynamic>;
      return data
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Server error: ${res.statusCode}');
  }
}
