import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  static List<Map<String, dynamic>> cartItems = [];

  static void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
  }

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _selectedIndex = 2;
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
        title: Text('Cart'),
      ),
      body: CartPage.cartItems.isEmpty
          ? Center(child: Text('No items in the cart'))
          : ListView.builder(
              itemCount: CartPage.cartItems.length,
              itemBuilder: (context, index) {
                final product = CartPage.cartItems[index];
                return ListTile(
                  leading: Image.network(
                    product['imageUrl'],
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(product['title']),
                  subtitle: Text('\$${product['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        CartPage.cartItems.removeAt(index);
                      });
                    },
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
