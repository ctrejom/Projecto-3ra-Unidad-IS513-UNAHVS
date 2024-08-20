import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/login_page.dart';
import 'package:myapp/register_page.dart';
import 'package:myapp/payment_page.dart';
import 'package:myapp/order_page.dart';
import 'package:myapp/cart_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// hola test
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Shopping',
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'Register': (context) => RegisterPage(),
        'Home': (context) => HomePage(),
        'Order': (context) => OrderPage(),
        'Cart': (context) => CartPage(),
        'Payment': (context) => PaymentPage(), 
      },
    );
  }
}
