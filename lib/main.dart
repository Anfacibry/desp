import 'package:desp/components/chart.dart';
import 'package:desp/components/listaAdd.dart';
import 'package:flutter/material.dart';

import 'components/listaTransacao.dart';
import 'models/transacao.dart';
import 'dart:math';

main() => runApp(Desp());

class Desp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.pink[800],
        fontFamily: "Akaya",
      ),
      home: DespHomePage(),
    );
  }
}

class DespHomePage extends StatefulWidget {
  @override
  _DespHomePageState createState() => _DespHomePageState();
}

class _DespHomePageState extends State<DespHomePage> {
  List<Transacao> _listaTransacao = [];

  List<Transacao> get _transacaoRecentes {
    return _listaTransacao.where((tran) {
      return tran.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addLista(String tituloRecebido, double valorRecebido, DateTime data) {
    Transacao addTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: tituloRecebido,
      valor: valorRecebido,
      data: data,
    );
    setState(() {
      _listaTransacao.add(addTransacao);
    });
    Navigator.of(context).pop();
  }

  _removendoItemLista(String idRecebido) {
    setState(() {
      _listaTransacao.removeWhere((element) => element.id == idRecebido);
    });
  }

  _modalForma(BuildContext contexto) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: contexto,
      builder: (_) {
        return ListaAdd(fun: addLista);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar barraPrincipal = AppBar(
      title: Text(
        "Desp",
        style: TextStyle(
          fontFamily: "Akaya",
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          iconSize: 35,
          padding: EdgeInsets.only(right: 20),
          icon: Icon(Icons.add),
          onPressed: () => _modalForma(context),
        ),
      ],
    );
    double tamanho = MediaQuery.of(context).size.height -
        barraPrincipal.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: barraPrincipal,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: tamanho * 0.3,
              child: Chart(transacaoRecente: _transacaoRecentes),
            ),
            _listaTransacao.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          "Nenhuma transação cadastrada!",
                          style: TextStyle(
                            fontSize: tamanho * 0.04,
                          ),
                        ),
                      ),
                      Container(
                        height: tamanho * 0.6,
                        child: Image.asset(
                          "assets/images/waiting.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                : Container(
                    height: tamanho * 0.7,
                    child: ListaTransacao(
                      transacao: _listaTransacao,
                      removendo: _removendoItemLista,
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: tamanho * 0.09,
        ),
        onPressed: () => _modalForma(context),
      ),
    );
  }
}
