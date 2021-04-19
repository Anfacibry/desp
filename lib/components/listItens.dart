import 'package:flutter/material.dart';

class ListaItens extends StatefulWidget {
  @override
  _ListaItensState createState() => _ListaItensState();
}

class _ListaItensState extends State<ListaItens> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            Container(
              //Container principal
              width: 200,
              height: 50,
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    "Despesas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
