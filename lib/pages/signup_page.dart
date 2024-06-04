import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../widgets/custom_choice_chip.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/step_indicator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int _currentStep = 0;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final MaskedTextController _phoneController =
  MaskedTextController(mask: '(00) 0 0000-0000');
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final MaskedTextController _birthDateController =
  MaskedTextController(mask: '00/00/0000');
  final MaskedTextController _weightController =
  MaskedTextController(mask: '000');

  final TextEditingController _medicalHistoryController =
  TextEditingController();

  String _selectedBloodType = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  String? _validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua data de nascimento';
    }

    try {
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      final DateTime dateOfBirth = dateFormat.parseStrict(value);

      final DateTime now = DateTime.now();
      final DateTime minimumDate = DateTime(1900);
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime adultDate = DateTime(now.year - 18, now.month, now.day);

      if (dateOfBirth.isBefore(minimumDate)) {
        return 'Data de nascimento não pode ser antes de 1900';
      } else if (dateOfBirth.isAtSameMomentAs(today)) {
        return 'Data de nascimento não pode ser o dia de hoje';
      } else if (dateOfBirth.isAfter(adultDate)) {
        return 'Você deve ter pelo menos 18 anos';
      }
    } catch (e) {
      return 'Por favor, insira uma data válida';
    }

    return null;
  }

  Future<void> _registerUser() async {
    final String apiUrl = 'http://localhost:3001/api/usuario/create';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nome': _nameController.text,
        'email': _emailController.text,
        'senha': _passwordController.text,
        'data_nascimento': _birthDateController.text,
        'telefone': _phoneController.text,
        'endereco': _addressController.text,
        'tipo_sanguineo': _selectedBloodType,
        'peso': _weightController.text,
        'historico_medico': _medicalHistoryController.text,
      }),
    );

    if (response.statusCode == 201) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: 'Sucesso',
        desc: 'Usuário cadastrado com sucesso!',
        btnOkOnPress: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
      ).show();
    } else {
      final message = jsonDecode(response.body)['message'] ?? 'Erro desconhecido';
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        title: 'Erro',
        desc: message,
        btnOkOnPress: () {},
        btnOkColor: Colors.red,
      ).show();
    }
  }

  String? _validateBloodType() {
    if (_selectedBloodType.isEmpty) {
      return 'Por favor, selecione um grupo sanguíneo';
    }
    return null;
  }

  void _onSubmit() {
      if (_formKeys[1].currentState?.validate() ?? false) {
        if (_validateBloodType() == null) {
          _registerUser();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Sucesso!',
            desc: 'Usuário cadastrado com sucesso!',
            btnOkOnPress: () {},
            btnOkColor: Colors.green,
          ).show();
          Navigator.of(context).pushReplacementNamed('/home');

        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            title: 'Atenção',
            desc: 'Por favor, selecione um grupo sanguíneo',
            btnOkOnPress: () {},
            btnOkColor: Colors.yellow,
          ).show();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFFFF3737),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registe-se para uma nova conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Crie uma Conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Insira os detalhes da sua conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _currentStep == 0 ? _buildStepOne() : _buildStepTwo(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepOne() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeys[0],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StepIndicator(text: 'Passo 1/2'),
            const SizedBox(height: 16.0),
            const Text(
              'Nome Completo',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              hintText: 'John Doe',
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome completo';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Email',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              hintText: 'example@gmail.com',
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu e-mail';
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(value)) {
                  return 'Por favor, insira um e-mail válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Telefone',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              hintText: '(15) 9 9999-9999',
              controller: _phoneController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu telefone';
                }
                if (value.length != 16) {
                  return 'Por favor, insira um telefone válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Endereço',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              hintText: 'Rua: example doe 123',
              controller: _addressController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu endereço';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Senha',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              hintText: 'Digite sua senha',
              obscureText: true,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                if (_formKeys[0].currentState?.validate() ?? false) {
                  setState(() {
                    _currentStep = 1;
                  });
                }
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
              child: const Text('Continuar'),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text(
                  'Você já tem uma conta? Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepTwo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeys[1],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _currentStep = 0;
                    });
                  },
                ),
                const Spacer(),
                const StepIndicator(text: 'Passo 2/2'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Icon(Icons.bloodtype, color: Colors.red, size: 24.0),
                SizedBox(width: 8.0),
                Text(
                  'Grupo Sanguíneo',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ['A+', 'O+', 'B+', 'AB+', 'A-', 'O-', 'B-', 'AB-']
                  .map((bloodType) => CustomChoiceChip(
                        label: bloodType,
                        isSelected: _selectedBloodType == bloodType,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedBloodType = selected ? bloodType : '';
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Icon(Icons.person, color: Colors.red, size: 24.0),
                SizedBox(width: 8.0),
                Text(
                  'Data de Nascimento',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: CustomTextField(
                  hintText: '01/01/2000',
                  icon: Icons.calendar_today,
                  controller: _birthDateController,
                  validator: _validateDateOfBirth,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Icon(Icons.person, color: Colors.red, size: 24.0),
                SizedBox(width: 8.0),
                Text(
                  'Peso',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              hintText: '65',
              suffixText: 'KG',
              controller: _weightController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu peso';
                }
                final weight = int.tryParse(value) ?? 0;
                if (weight > 200) {
                  return 'O Peso deve ser no máximo 200KG';
                } else if (weight < 50) {
                  return 'O peso minimo é 50KG';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Histórico médico',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            CustomTextField(
              hintText: 'Descreva suas condições médicas...',
              maxLines: 3,
              controller: _medicalHistoryController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu histórico médico';
                }
                return null;
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _onSubmit,
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
              child: const Text('Feito'),
            ),
          ],
        ),
      ),
    );
  }
}
