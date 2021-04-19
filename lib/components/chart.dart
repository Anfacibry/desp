import 'package:desp/components/chart_bar.dart';
import 'package:desp/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transacao> transacaoRecente;

  Chart({
    @required this.transacaoRecente,
  });

  List<Map<String, Object>> get grupoTransacao {
    return List.generate(7, (index) {
      final diaAtual = DateTime.now().subtract(
        Duration(days: index),
      );

      double somaTotal = 0.0;
      for (int i = 0; i < transacaoRecente.length; i++) {
        bool dia = transacaoRecente[i].data.day == diaAtual.day;
        bool mes = transacaoRecente[i].data.month == diaAtual.month;
        bool ano = transacaoRecente[i].data.year == diaAtual.year;
        if (dia && mes && ano) {
          somaTotal += transacaoRecente[i].valor;
        }
      }
      return {
        "dia": DateFormat.E().format(diaAtual)[0],
        "valor": somaTotal,
      };
    }).reversed.toList();
  }

  double get _retornoPorcento {
    return grupoTransacao.fold(
        0.0, (previousValue, element) => previousValue + element["valor"]);
  }

  @override
  Widget build(BuildContext context) {
    grupoTransacao;
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grupoTransacao.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBart(
                label: tr["dia"],
                valor: tr["valor"],
                porcento: _retornoPorcento == 0
                    ? 0
                    : (tr["valor"] as double) / _retornoPorcento,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
