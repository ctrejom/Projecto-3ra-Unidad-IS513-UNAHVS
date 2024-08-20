import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/Widgets/TextFormCustom.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final nombreController = TextEditingController();
  final contraseniaController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text('Login', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Bienvenido', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 50,fontWeight: FontWeight.w100)),
                SizedBox(height: 30),

                  TextFormCustom(
                  controller: nombreController,
                  label: 'Nombre de Usuario',
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4277292450.
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), 
                  fontSize: 15, fontWeight: FontWeight.w300),
                  icon: Icons.person,
                  validator: (valor) {
                    return null;
                  }, 
                  
                ),
                TextFormCustom(
                  controller: contraseniaController,
                  label: 'Contraseña',
                  
                  icon: Icons.lock,
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                  obscureText: true,
                  validator: (valor) {
                    return null; 
                  }, 
                  
                ),
                SizedBox(height: 220),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'Home');
                      },
                      child: const Text('Iniciar sesión'),
                    ),
                    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          padding: EdgeInsets.all(30),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: TextStyle(
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
