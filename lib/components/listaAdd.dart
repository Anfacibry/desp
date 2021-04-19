import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaAdd extends StatefulWidget {
  final void Function(String, double, DateTime) fun;

  ListaAdd({
    @required this.fun,
  });

  @override
  _ListaAddState createState() => _ListaAddState();
}

class _ListaAddState extends State<ListaAdd> {
  final tituloController = TextEditingController();

  final valorController = TextEditingController();
  DateTime dataSelecionada;

  void _addLista() {
    final titulo = tituloController.text;
    final valor = double.parse(valorController.text);
    if (titulo.isEmpty || valor <= 0) {
      return;
    }
    widget.fun(titulo, valor, dataSelecionada);
  }

  _selecionandoData() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((dataEscolhida) {
      if (dataEscolhida == null) {
        return;
      }
      setState(() {
        dataSelecionada = dataEscolhida;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.name,
                controller: tituloController,
                onSubmitted: (_) => _addLista(),
                decoration: InputDecoration(
                  labelText: "Titulo",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: valorController,
                onSubmitted: (_) => _addLista(),
                decoration: InputDecoration(
                  labelText: "Valor R\$",
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      dataSelecionada == null
                          ? "Selecionar data!"
                          : "Data selecionada ${DateFormat("dd/MM/y").format(dataSelecionada)}",
                    ),
                    TextButton(
                      onPressed: _selecionandoData,
                      child: Text(
                        "Nova Data",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).accentColor,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    "Salvar transação!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _addLista,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
