import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CartPage'),
      ),
      body: Center(
        child: Text('This is the Cart Page'),
      ),
    );
  }
}
