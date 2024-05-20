import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int _currentStep = 0;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Registe-se para uma nova conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Crie uma Conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Insira os detalhes da sua conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lexend',
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
            _buildStepIndicator('Passo 1/2'),
            const SizedBox(height: 16.0),
            const Text(
              'Nome Completo',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            _buildTextField('John Doe'),
            const SizedBox(height: 16.0),
            const Text(
              'Email',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            _buildTextField('example@gmail.com'),
            const SizedBox(height: 16.0),
            const Text(
              'Telefone',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            _buildTextField('(15) 9 9999-9999'),
            const SizedBox(height: 16.0),
            const Text(
              'Endereço',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            _buildTextField('Rua: example doe 123'),
            const SizedBox(height: 16.0),
            const Text(
              'Senha',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            _buildTextField('password', obscureText: true),
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
                backgroundColor: const Color(0xFFFF3737),
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize:
                    const Size.fromHeight(61), // Mantém a mesma altura do input
              ),
              child: const Text('Continuar'),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  // Ação do botão "Login"
                },
                child: const Text(
                  'Você já tem uma conta? Login',
                  style: TextStyle(
                    color: Color(0xFFFF3737),
                    fontSize: 20,
                    fontFamily: 'Lexend',
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
                _buildStepIndicator('Passo 2/2'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Grupo de Sangue*',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ['A+', 'O+', 'B+', 'AB+', 'A-', 'O-', 'B-', 'AB-']
                  .map((bloodType) => ChoiceChip(
                        label: Text(bloodType),
                        selected: false,
                        onSelected: (bool selected) {},
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Data de Nascimento',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            _buildTextField('01/01/2000', icon: Icons.calendar_today),
            const SizedBox(height: 16.0),
            const Text(
              'Peso',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            _buildTextField('65', suffixText: 'KG'),
            const SizedBox(height: 16.0),
            const Text(
              'Histórico médico',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            _buildTextField(
              'Descreva suas condições médicas...',
              maxLines: 3,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                if (_formKeys[1].currentState?.validate() ?? false) {
                  // Lógica para salvar os dados ou navegar para outra página
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3737),
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Lexend',
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

  Widget _buildTextField(String hintText,
      {bool obscureText = false,
      IconData? icon,
      int maxLines = 1,
      String? suffixText}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: icon != null ? Icon(icon) : null,
          suffixText: suffixText,
        ),
      ),
    );
  }

  Widget _buildStepIndicator(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: const Color(0xFF333333),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
