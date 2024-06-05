import 'package:flutter/material.dart';
import 'package:doasan/widgets/custom_app_bar.dart';
import 'package:doasan/widgets/custom_bottom_nav_bar.dart';
//import 'package:mongo_dart/mongo_dart.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Doasan - Sorocaba',
        //isAdmin: userType == 'admin',
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _abrirPaginaSelecaoDatas(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF3737),
            foregroundColor: Colors.white,
            minimumSize: const Size(200, 50),
          ),
          child: const Text(
            'Gerar Relatório',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {},
        userType: 'admin',
      ),
    );
  }

  void _abrirPaginaSelecaoDatas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaginaSelecaoIntervaloDatas()),
    );
  }
}

class PaginaSelecaoIntervaloDatas extends StatefulWidget {
  @override
  _PaginaSelecaoIntervaloDatasState createState() =>
      _PaginaSelecaoIntervaloDatasState();
}

class _PaginaSelecaoIntervaloDatasState
    extends State<PaginaSelecaoIntervaloDatas> {
  DateTime _dataInicio = DateTime(2024, 1, 1);
  DateTime _dataFim = DateTime.now();

  Future<void> _selecionarDataInicio(BuildContext context) async {
    final DateTime? escolhidaInicio = await showDatePicker(
      context: context,
      initialDate: _dataInicio,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale('pt', 'BR'),
    );
    if (escolhidaInicio != null && escolhidaInicio != _dataInicio)
      setState(() {
        _dataInicio = escolhidaInicio;
      });
  }

  Future<void> _selecionarDataFim(BuildContext context) async {
    final DateTime? escolhidaFim = await showDatePicker(
      context: context,
      initialDate: _dataFim,
      firstDate: _dataInicio,
      lastDate: DateTime.now(),
      locale: Locale('pt', 'BR'),
    );
    if (escolhidaFim != null &&
        escolhidaFim != _dataFim &&
        escolhidaFim.isBefore(DateTime.now()))
      setState(() {
        _dataFim = escolhidaFim;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleção de Intervalo de Datas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Data de Início: ${_dataInicio.toString()}'),
            ElevatedButton(
              onPressed: () => _selecionarDataInicio(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3737),
                foregroundColor: Colors.white,
              ),
              child: Text('Selecione a Data Inícial'),
            ),
            SizedBox(height: 20),
            Text('Data de Fim: ${_dataFim.toString()}'),
            ElevatedButton(
              onPressed: () => _selecionarDataFim(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3737),
                foregroundColor: Colors.white,
              ),
              child: Text('Selecione a Data Final'),
            ),
          ],
        ),
      ),
    );
  }
}
