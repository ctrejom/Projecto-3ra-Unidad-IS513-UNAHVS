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
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Bienvenido', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 50,fontWeight: FontWeight.w100)),
                const SizedBox(height: 30),

                  TextFormCustom(
                  controller: nombreController,
                  label: 'Nombre de Usuario',
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), 
                  fontSize: 15, fontWeight: FontWeight.w300),
                  icon: Icons.person,
                  validator: (valor) {
                    if ((valor!.isEmpty)) {
                        return 'El nombre es obligatorio';
                      }
                      final usuario = valor.toUpperCase();
                      if ((usuario != 'CTREJOM@UNAH.HN') &&
                          (usuario != 'WAI.TSE@UNAH.HN') &&
                          (usuario != 'ALLANCRUZ@UNAH.HN')) {
                        return 'El Usuario que ingresó es incorrecto';
                      }
                      return null;
                  }, 
                  
                ),
                TextFormCustom(
                  controller: contraseniaController,
                  label: 'Contraseña',
                  
                  icon: Icons.lock,
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                  obscureText: true,
                  validator: (valor) {
                     if ((valor!.isEmpty)) {
                        return 'La Contraseña es obligatoria';
                      }
                      final usuario = nombreController.text.toUpperCase();
                      if (usuario == 'CTREJOM@UNAH.HN' &&
                          valor != '20212000569') {
                        return 'Contraseña incorrecta para el usuario';
                      } else if (usuario == 'WAI.TSE@UNAH.HN' &&
                          valor != '20212000972') {
                        return 'Contraseña incorrecta para el usuario';
                      } else if (usuario == 'ALLANCRUZ@UNAH.HN' &&
                          valor != '20192002956') {
                        return 'Contraseña incorrecta para el usuario';
                      }
                    return null; 
                  }, 
                  
                ),
                const SizedBox(height: 220),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                            Navigator.pushReplacementNamed(
                              context, 'Home');
                          }
                      },
                      child: const Text('Iniciar sesión'),
                    ),
                    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          padding: const EdgeInsets.all(30),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'Register');
                      },
                      child: const Text('Registrarse'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
