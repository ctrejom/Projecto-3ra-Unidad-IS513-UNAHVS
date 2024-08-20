import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key});

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
      backgroundColor: Color.fromARGB(255, 10, 10, 10),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
         title: Text('Payment', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100)),
      ),
      body: OrderPage.orderItems.isEmpty
          ? Center(child: Text('No orders placed'))
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
                  title: Text(product['title'],style: TextStyle(color: Colors.white)),
                  subtitle: Text(style: TextStyle(color: Color.fromARGB(255, 60, 255, 0)),
                    '\$${product['price']} x ${product['quantity']}',
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
