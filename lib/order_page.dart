import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  static List<Map<String, dynamic>> orderItems = [];

  static void addToOrder(List<Map<String, dynamic>> items) {
    orderItems.addAll(items);
  }

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _selectedIndex = 1;

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
      backgroundColor: const Color.fromARGB(255, 0, 0, 0), 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text('Payment', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100)),
      ),
      body: OrderPage.orderItems.isEmpty
          ? const Center(child: Text('No orders placed', style: TextStyle(color: Colors.white))) // Texto en blanco
          : ListView.builder(
              itemCount: OrderPage.orderItems.length,
              itemBuilder: (context, index) {
                final product = OrderPage.orderItems[index];
                return ListTile(
                  leading: Image.network(
                    product['imageUrl'],
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(product['title'], style: const TextStyle(color: Colors.white)), // Título en blanco
                  subtitle: Text(
                    '\$${product['price']} x ${product['quantity']}',
                    style: const TextStyle(color: Color.fromARGB(255, 60, 255, 0)), // Subtítulo en verde
                  ),
                );
              },
            ),
      bottomNavigationBar: NavigationBarCustom(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
