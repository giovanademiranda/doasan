import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserNotification {
  final String message;
  final String date;
  final String time;
  final String location;

  UserNotification({
    required this.message,
    required this.date,
    required this.time,
    required this.location,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      message: json['message'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
    );
  }
}


class NotificationService {
  static const String baseUrl = 'http://localhost:3001/api';

  Future<List<UserNotification>> fetchNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      throw Exception('Usuário não autenticado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/agendamento/$userId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<UserNotification> notifications = body
          .map((dynamic item) => UserNotification.fromJson(item))
          .toList();
      return notifications;
    } else {
      throw Exception('Erro ao carregar notificações');
    }
  }
}
