import 'package:flutter/material.dart';

class ContacPage extends StatefulWidget {
  ContacPage({Key key}) : super(key: key);

  _ContacPageState createState() => _ContacPageState();
}

class _ContacPageState extends State<ContacPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Contactos'),
      ),
      body: Center(
        child: Text('Contactos listas'),
      ),
    );
  }
}