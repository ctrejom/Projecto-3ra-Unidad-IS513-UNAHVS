import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';
import 'Widgets/TextFormCustom.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 10, 10),
        title: const Text('Payment', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey, 
            child: Column(
              children: [
                TextFormCustom(
                  label: 'Please enter your card number',
                  controller: tarjetaController,
                  icon: Icons.add_card,
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
                const SizedBox(height: 5),
                TextFormCustom(
                  label: 'CVV',
                  controller: cvvController,
                  icon: Icons.add_card,
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
                const SizedBox(height: 5),
                TextFormCustom(
                  label: 'Expiration Date (MM)',
                  controller: mesController,
                  icon: Icons.date_range,
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Please enter a value';
                    }
                    if(valor.isEmpty || valor.length > 2)
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
                const SizedBox(height: 5),
                TextFormCustom(
                  label: 'Expiration Date (AA)',
                  controller: anioController,
                  icon: Icons.date_range,
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Please enter a value';
                    }
                    if(valor.isEmpty || valor.length > 2)
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
                const SizedBox(height: 110),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromRGBO(30, 30, 30, 1),
                          backgroundColor: Color.fromRGBO(30, 30, 30, 1),
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        PaymentPage.hasCreditCard = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Payment method added!', style: TextStyle(color: Colors.white))),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter all the corresponding values.',style: TextStyle(color: Colors.white))),
                      );
                    }
                  },
                  child: const Text('Save Payment Method',style: TextStyle(color: Colors.white)),
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
