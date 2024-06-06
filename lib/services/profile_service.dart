import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  static const String baseUrl = 'http://localhost:3001/api';

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usuario/$userId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
