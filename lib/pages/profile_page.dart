import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/user_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  final User? user;

  const ProfilePage({super.key, this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  bool isLoading = true;
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user!;
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3001/api/usuario/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          final userData = jsonDecode(response.body)['usuario'];
          user = User.fromJson(userData);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showErrorDialog(
            'Erro ao carregar dados do perfil. Por favor, tente novamente.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog('Ocorreu um erro. Por favor, tente novamente.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onBottomNavTap(int index) {
    if (index == 0) {
      if (user.name == 'admin') {
        Navigator.of(context)
            .pushReplacementNamed('/admin_home', arguments: user);
      } else {
        Navigator.of(context).pushReplacementNamed('/home', arguments: user);
      }
    } else if (index == 1) {
      Navigator.of(context).pushReplacementNamed('/schedule');
    } else if (index == 2) {
      Navigator.of(context).pushReplacementNamed('/notifications');
    } else if (index == 3) {
      Navigator.of(context).pushReplacementNamed('/profile', arguments: user);
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Doasan - Sorocaba',
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Perfil',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildProfileField('Nome Completo', user.name),
                  buildProfileField('Email', user.email),
                  buildProfileField('Telefone', user.phone),
                  buildProfileField('Endereço', user.address),
                  buildProfileField('Grupo de Sangue', user.bloodType),
                  buildProfileField('Data de Nascimento', user.birthDate),
                  buildProfileField('Peso', user.weight.toString()),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFFF3737),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: const Size.fromHeight(61),
                      ),
                      child: const Text('Sair'),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        userType: user.name == 'admin' ? 'admin' : 'user',
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
