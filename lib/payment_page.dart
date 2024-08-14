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
            key: _formKey, // Asignas la GlobalKey al Form
            child: Column(
              children: [
                TextFormCustom(
                  label: 'Ingrese los Numeros de su Tarjeta',
                  controller: tarjetaController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Por favor, ingrese su número de tarjeta';
                    } else if (valor.length != 16) {
                      return 'El número de la tarjeta debe tener 16 dígitos';
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
                      return 'Por favor, ingrese su CVV';
                    } else if (valor.length != 3) {
                      return 'El CVV debe tener 3 dígitos';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                TextFormCustom(
                  label: 'Fecha Expiración (MM)',
                  controller: mesController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Ingrese un valor';
                    }
                    if(valor.length < 1 || valor.length > 2)
                    {
                      return 'Debe ingresar solo 2 numeros';
                    }
                    final int? numero = int.tryParse(valor);
                    if (numero == null || numero < 1 || numero > 12) {
                      return 'Debe ingresar un número del 1 al 12';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                TextFormCustom(
                  label: 'Fecha Expiración (AA)',
                  controller: anioController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Ingrese un valor';
                    }
                    if(valor.length < 1 || valor.length > 2)
                    {
                      return 'Debe ingresar solo 2 numeros';
                    }
                    final int? numero = int.tryParse(valor);
                    if (numero == null || numero < DateTime.now().year % 100) {
                      return 'Debe ingresar un año válido';
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
                        SnackBar(content: Text('Tarjeta registrada exitosamente!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Por favor, complete todos los campos correctamente.')),
                      );
                    }
                  },
                  child: Text('Guardar Tarjeta'),
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
