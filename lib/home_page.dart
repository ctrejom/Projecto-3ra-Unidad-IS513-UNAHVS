import 'package:flutter/material.dart';
import 'Widgets/TextFormCustom.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Bienvenido a la página de inicio'),
      ),
    );
  }
}
