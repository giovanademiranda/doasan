import 'dart:convert';
import 'package:http/http.dart' as http;

class ScheduleService {
  static const String baseUrl = 'http://localhost:3001/api';

  Future<Map<String, dynamic>> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuario/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'senha': senha,
      }),
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        ...jsonDecode(response.body),
      };
    } else {
      return {
        'success': false,
        'message': 'Failed to login',
      };
    }
  }

  Future<Map<String, dynamic>> scheduleAppointment(String userId, Map<String, dynamic> appointmentData) async {
    final String apiUrl = '$baseUrl/agendamento/create/$userId';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(appointmentData),
    );

    if (response.statusCode == 201) {
      return {
        'success': true,
        'message': 'Agendamento realizado com sucesso!'
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
