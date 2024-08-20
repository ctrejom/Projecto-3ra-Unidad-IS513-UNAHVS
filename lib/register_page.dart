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
      
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text('Registro', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300)),
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
                    icon: Icons.person,
                   style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                    validator: (value) {
                      return null;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1859046140.
                    }, 
                  ),
                  TextFormCustom(
                    label: 'Correo Electrónico',
                    icon: Icons.email,
                   style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                    controller: correoController,
                    validator: (value) {
                      return null;
                    }, 
                  ),
                  TextFormCustom(
                    label: 'Teléfono',
                    controller: telefonoController,
                    icon: Icons.phone,
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return null;
                    }, 
                  ),
                  TextFormCustom(
                    label: 'Contraseña',
                    icon: Icons.password,
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
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
                      style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                      child: const Text('Registrar'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 5, 5, 5),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'login');
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
