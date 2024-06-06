import 'package:doasan/widgets/custom_app_bar.dart';
import 'package:doasan/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
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

  // Future<Map<String, int>> _obterDadosDoacoes() async {
  //   final db = await mongo.Db.create("mongodb://localhost:27017/hemocentro");
  //   await db.open();

  //   final collection = db.collection('agendamento');
  //   final pipeline = [
  //     {
  //       '\$match': {
  //         'data_doacao': {
  //           '\$gte': _dataInicio,
  //           '\$lte': _dataFim,
  //         }
  //       }
  //     },
  //     {
  //       '\$group': {
  //         '_id': '\$tipo_sanguineo',
  //         'count': {'\$sum': 1}
  //       }
  //     }
  //   ];

  //   final result = await collection.aggregate(pipeline);

  //   await db.close();

  //   final Map<String, int> doacoesPorTipo = {};
  //   for (var doc in result) {
  //     doacoesPorTipo[doc['_id']] = doc['count'];
  //   }

  //   return doacoesPorTipo;
  // }

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

// class GraficoDoacoes extends StatelessWidget {
//   final Map<String, int> doacoes;

//   GraficoDoacoes({required this.doacoes});

//   @override
//   Widget build(BuildContext context) {
//     List<charts.Series<Doacao, String>> series = [
//       charts.Series(
//         id: "Doacoes",
//         data: doacoes.entries
//             .map((entry) => Doacao(tipo: entry.key, quantidade: entry.value))
//             .toList(),
//         domainFn: (Doacao doacao, _) => doacao.tipo,
//         measureFn: (Doacao doacao, _) => doacao.quantidade,
//         colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
//       )
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gráfico de Doações por Tipo Sanguíneo'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: charts.BarChart(
//             series,
//             animate: true,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Doacao {
//   final String tipo;
//   final int quantidade;

//   Doacao({required this.tipo, required this.quantidade});
// }
