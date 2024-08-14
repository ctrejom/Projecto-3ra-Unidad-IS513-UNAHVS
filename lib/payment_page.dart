import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';
import 'Widgets/TextFormCustom.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({super.key});

  static bool hasCreditCard = false;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedIndex = 3;
  final tarjetaController = TextEditingController();
  final cvvController = TextEditingController();
  final mesController = TextEditingController();
  final anioController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, 'Home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, 'Order');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, 'Cart');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, 'Payment');
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
          child: Form(
            key: _formKey, 
            child: Column(
              children: [
                TextFormCustom(
                  label: 'Please enter your card number',
                  controller: tarjetaController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Please provide your card number';
                    } else if (valor.length != 16) {
                      return 'Your card number must be 16 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                TextFormCustom(
                  label: 'CVV',
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Please provide your CVV';
                    } else if (valor.length != 3) {
                      return 'Your CVV must be 3 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                TextFormCustom(
                  label: 'Expiration Date (MM)',
                  controller: mesController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Please enter a value';
                    }
                    if(valor.length < 1 || valor.length > 2)
                    {
                      return 'Please enter 2 valid digits';
                    }
                    final int? numero = int.tryParse(valor);
                    if (numero == null || numero < 1 || numero > 12) {
                      return 'Please enter a valid month (i.e. 1-12)';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                TextFormCustom(
                  label: 'Expiration Date (AA)',
                  controller: anioController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Please enter a value';
                    }
                    if(valor.length < 1 || valor.length > 2)
                    {
                      return 'Please enter 2 valid digits';
                    }
                    final int? numero = int.tryParse(valor);
                    if (numero == null || numero < DateTime.now().year % 100) {
                      return 'Please enter a valid year (i.e. >24)';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        PaymentPage.hasCreditCard = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Payment method added!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter all the corresponding values.')),
                      );
                    }
                  },
                  child: Text('Save Payment Method'),
                ),
              ],
            ),
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
