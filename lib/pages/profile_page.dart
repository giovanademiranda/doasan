import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  final String userType;

  const ProfilePage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final userData = mockUser;

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
                'Perfil',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildProfileField('Nome Completo', userData.name),
            buildProfileField('Email', userData.email),
            buildProfileField('Telefone', userData.phone),
            buildProfileField('Endereço', userData.address),
            buildProfileField('Grupo de Sangue', userData.bloodType),
            buildProfileField('Data de Nascimento', userData.birthDate),
            buildProfileField('Peso', userData.weight),
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
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            if (userType == 'admin') {
              Navigator.of(context).pushReplacementNamed('/admin_home');
            } else {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          }
        },
        userType: userType,
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
