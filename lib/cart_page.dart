import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';

class CartPage extends StatefulWidget {
 CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushNamed(context, 'Home');
          break;
        case 1:
          Navigator.pushNamed(context, 'Order');
          break;
        case 2:
          Navigator.pushNamed(context, 'Cart');
          break;
        case 3:
          Navigator.pushNamed(context, 'Payment');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CartPage'),
      ),
      body: Center(
        child: Text('This is the CartPage'),
      ),
      bottomNavigationBar: NavigationBarCustom(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
