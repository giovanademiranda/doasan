import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  static const String baseUrl = 'http://localhost:3001/api';

  Future<Map<String, dynamic>> getReport(String startDate, String endDate) async {
    final response = await http.post(
      Uri.parse('$baseUrl/agendamento/getReport'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'data_inicial': startDate,
        'data_final': endDate,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao buscar relatório');
    }
  }
}
