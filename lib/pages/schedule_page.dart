import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_text_field.dart';

class ScheduleScreen extends StatefulWidget {
  final String doadorId;

  const ScheduleScreen({super.key, required this.doadorId});

  get user => null;

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _centerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = '01/01/2024';
    _timeController.text = '12:30h';
    _centerController.text = 'Doasan Sorocaba';
  }

  Future<void> _scheduleDonation() async {
    if (_formKey.currentState!.validate()) {
      final url = 'http://localhost:3001/api/agendamento/create/${widget.doadorId}';
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'data_doacao': _dateController.text,
        'hora_doacao': _timeController.text,
        'centro_coleta': _centerController.text,
      });

      try {
        final response = await http.post(Uri.parse(url), headers: headers, body: body);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Agendamento realizado com sucesso!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao realizar agendamento.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro de rede: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Doasan - Sorocaba',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Agendamentos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Data da Doação',
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a data da doação';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Hora',
                    controller: _timeController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a hora da doação';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Centro de Coleta',
                    controller: _centerController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o centro de coleta';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _scheduleDonation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3737),
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    ),
                    child: const Text('Feito', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (index == 1) {
            Navigator.of(context).pushReplacementNamed('/schedule', arguments: {'doadorId': widget.doadorId});
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed('/notifications');
          } else if (index == 3) {
            Navigator.of(context).pushReplacementNamed('/profile', arguments: {'user': widget.user});
          }
        },
        userType: 'user',
      ),
    );
  }
}
