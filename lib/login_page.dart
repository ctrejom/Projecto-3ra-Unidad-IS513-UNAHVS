import 'package:flutter/material.dart';
import 'package:myapp/Widgets/TextFormCustom.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final nombreController = TextEditingController();
  final contraseniaController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bienvenido'),
                SizedBox(height: 20),
                TextFormCustom(
                  controller: nombreController,
                  label: 'Nombre de Usuario',
                  validator: (valor) {
                    return null;
                  },
                ),
                TextFormCustom(
                  controller: contraseniaController,
                  label: 'Contraseña',
                  obscureText: true,
                  validator: (valor) {
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'Home');
                      },
                      child: const Text('Iniciar sesión'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'Registrar');
                      },
                      child: const Text('Registrarse'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
