import 'package:desp/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaTransacao extends StatelessWidget {
  final List<Transacao> transacao;
  final void Function(String) removendo;

  ListaTransacao({
    @required this.transacao,
    @required this.removendo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: ListView.builder(
        itemCount: transacao.length,
        itemBuilder: (context, indice) {
          final tr = transacao[indice];
          return Card(
            margin: EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 15,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text("R\$${tr.valor}"),
                  ),
                ),
              ),
              title: Text(tr.titulo),
              subtitle: Text(
                DateFormat("d MMM y").format(tr.data),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[600],
                ),
                onPressed: () => removendo(tr.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
