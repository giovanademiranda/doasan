import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/profile_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro: Usuário não autenticado')),
      );
      return;
    }

    final userProfile = await ProfileService().getUserProfile(userId);

    if (userProfile != null) {
      setState(() {
        _nameController.text = userProfile['nome'];
        _emailController.text = userProfile['email'];
        _phoneController.text = userProfile['telefone'];
        _addressController.text = userProfile['endereco'];
        _bloodTypeController.text = userProfile['tipo_sanguineo'];
        _birthDateController.text = userProfile['data_nascimento'];
        _weightController.text = userProfile['peso'].toString();
      });
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Doasan - Sorocaba',
      ),
      body: SingleChildScrollView(
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
            const Text(
              'Nome Completo',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'John Doe',
              controller: _nameController,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Email',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'example@gmail.com',
              controller: _emailController,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Telefone',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: '(15) 9 9999-9999',
              controller: _phoneController,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Endereço',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'Rua: example doe 123',
              controller: _addressController,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Grupo de Sangue',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'A+',
              controller: _bloodTypeController,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Data de Nascimento',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: '01/01/2000',
              controller: _birthDateController,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Peso',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: '65',
              controller: _weightController,
              readOnly: true,
              suffixText: 'KG',
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: const Size.fromHeight(61),
                ),
                child: const Text('Sair'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (index == 1) {
            Navigator.of(context).pushReplacementNamed('/schedule');
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed('/notifications');
          } else if (index == 3) {
            Navigator.of(context).pushReplacementNamed('/profile');
          }
        },
      ),
    );
  }
}
