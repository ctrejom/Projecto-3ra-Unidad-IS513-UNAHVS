import 'package:flutter/material.dart';
import 'package:myapp/Widgets/TextFormCustom.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final telefonoController = TextEditingController();
  final contraseniaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormCustom(
                    label: 'Nombre',
                    controller: nombreController,
                    validator: (value) {
                      return null;
                    },
                  ),
                  TextFormCustom(
                    label: 'Correo Electrónico',
                    controller: correoController,
                    validator: (value) {
                      return null;
                    },
                  ),
                  TextFormCustom(
                    label: 'Teléfono',
                    controller: telefonoController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return null;
                    },
                  ),
                  TextFormCustom(
                    label: 'Contraseña',
                    controller: contraseniaController,
                    obscureText: true,
                    validator: (value) {

                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            Navigator.pushNamed(context, 'login');
                          }
                        },
                        child: const Text('Registrar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
