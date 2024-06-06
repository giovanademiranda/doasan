import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  static const String baseUrl = 'http://localhost:3001/api';

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
    final String apiUrl = '$baseUrl/usuario/create';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      return {
        'success': true,
        'message': 'Usuário cadastrado com sucesso!'
      };
    } else {
      final message = jsonDecode(response.body)['message'] ?? 'Erro desconhecido';
      return {
        'success': false,
        'message': message
      };
    }
  }
}
