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
      
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text('Registro', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300)),
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
                   style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      if (value.length < 3 || value.length > 10) {
                        return 'El nombre debe contener entre 3 y 10 caracteres';
                      }
                      return null;
                    }, 
                  ),
                  TextFormCustom(
                    label: 'Correo Electrónico',
                    icon: Icons.email,
                   style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                    controller: correoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El Correo Electrónico es obligatorio';
                      }
                      if (!value.contains('@')) {
                        return 'El Correo Electrónico debe contener un @';
                      }
                      if (value.indexOf('@') != value.lastIndexOf('@')) {
                        return 'No puede haber más de un @';
                      }
                      if (!value.endsWith('@unah.hn')) {
                        return 'El Correo Electrónico debe contener unah.hn';
                      }
                      if (value.contains(' ')) {
                        return 'El Correo Electrónico no puede contener espacios';
                      }
                      return null;
                    }, 
                  ),
                  TextFormCustom(
                    label: 'Teléfono',
                    controller: telefonoController,
                    icon: Icons.phone,
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El Teléfono es obligatorio';
                      }
                      if (value.length != 8) {
                        return 'El Teléfono debe tener exactamente 8 números';
                      }
                      if (value[0] != '3' && value[0] != '9') {
                        return 'El Teléfono debe iniciar con 3 o 9';
                      }
                      if (value.contains(' ')) {
                        return 'El Teléfono no puede contener espacios';
                      }
                      if (value.contains(',') || value.contains('.')) {
                        return 'El Teléfono no puede contener puntos o comas';
                      }
                      if (value.contains('-')) {
                        return 'El Teléfono no puede contener guiones';
                      }
                      return null;
                    }, 
                  ),
                  TextFormCustom(
                    label: 'Contraseña',
                    icon: Icons.password,
                    style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15, fontWeight: FontWeight.w300),
                    controller: contraseniaController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La Contraseña es obligatoria';
                      }
                      if (value.length < 8) {
                        return 'La Contraseña debe tener al menos 8 caracteres';
                      }
                      if (value.contains(' ')) {
                        return 'La Contraseña no puede contener espacios';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'La Contraseña debe tener al menos una mayúscula';
                      }
                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'La Contraseña debe tener al menos una minúscula';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'La Contraseña debe tener al menos un número';
                      }
                      if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                        return 'La Contraseña debe tener al menos un caracter especial';
                      }

                      return null;
                    }, 
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Succesfully registered', style: TextStyle(color: Colors.white)),
                              backgroundColor: Color.fromRGBO(30, 30, 30, 1),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, 'login');
                      },
                      child: const Text('Registrar'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 5, 5, 5),
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
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
