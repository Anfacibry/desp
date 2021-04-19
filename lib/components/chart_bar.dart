import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBart extends StatelessWidget {
  final String label;
  final double valor;
  final double porcento;

  ChartBart({
    @required this.label,
    @required this.valor,
    @required this.porcento,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text("${valor.toStringAsFixed(2)}"),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: constraints.maxWidth * 0.2,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: constraints.maxWidth * 0.01,
                    ),
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: porcento,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: Text(label),
          ),
        ],
      );
    });
  }
}
