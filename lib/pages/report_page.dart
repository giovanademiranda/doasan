import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import '../services/reports_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_text_field.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MaskedTextController _startDateController = MaskedTextController(mask: '00/00/0000');
  final MaskedTextController _endDateController = MaskedTextController(mask: '00/00/0000');
  Map<String, dynamic>? _reportData;

  Future<void> _selectDate(BuildContext context, MaskedTextController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _generateReport() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final report = await ReportService().getReport(_startDateController.text, _endDateController.text);
        setState(() {
          _reportData = report;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao gerar relatório: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Relatórios',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gerar Relatório de Agendamentos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Data Inicial',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context, _startDateController),
                child: IgnorePointer(
                  child: CustomTextField(
                    controller: _startDateController,
                    hintText: '01/01/2022',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a data inicial';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Data Final',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context, _endDateController),
                child: IgnorePointer(
                  child: CustomTextField(
                    controller: _endDateController,
                    hintText: '31/12/2022',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a data final';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _generateReport,
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
                  child: const Text('Gerar Relatório'),
                ),
              ),
              const SizedBox(height: 24),
              _reportData != null
                  ? Expanded(
                child: ListView.builder(
                  itemCount: _reportData!.length,
                  itemBuilder: (context, index) {
                    String key = _reportData!.keys.elementAt(index);
                    return ListTile(
                      title: Text('$key: ${_reportData![key]}'),
                    );
                  },
                ),
              )
                  : const Text('Nenhum relatório gerado'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/home');
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
