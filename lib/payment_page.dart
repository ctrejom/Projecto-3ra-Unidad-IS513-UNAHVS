import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';
import 'Widgets/TextFormCustom.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedIndex = 3;
  final tarjetaController = TextEditingController();
  final cvvController = TextEditingController();
  final fechaController = TextEditingController();

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
        title: Text('PaymentPage'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormCustom(
                label: 'Ingrese los Numeros de su Tarjeta',
                controller: tarjetaController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5),
              TextFormCustom(
                label: 'CVV',
                controller: cvvController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5),
              TextFormCustom(
                label: 'FechaExpiracion(MM/AA)',
                controller: fechaController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarCustom(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
