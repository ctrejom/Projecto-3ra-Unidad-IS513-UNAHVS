import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';
import 'order_page.dart';
import 'payment_page.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  static List<Map<String, dynamic>> cartItems = [];

  static void addToCart(Map<String, dynamic> product) {
    final existingProduct = cartItems.firstWhere(
      (item) => item['title'] == product['title'],
      orElse: () => {},
    );
    if (existingProduct.isEmpty) {
      product['quantity'] = 1;
      cartItems.add(product);
    } else {
      existingProduct['quantity'] += 1;
    }
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

  double calculateTotalPrice() {
    return CartPage.cartItems.fold(0.0, (total, product) {
      return total + (product['price'] * product['quantity']);
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
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                        subtitle: Text(
                          '\$${product['price']} x ${product['quantity']} = \$${(product['price'] * product['quantity']).toStringAsFixed(2)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (product['quantity'] > 1) {
                                    product['quantity'] -= 1;
                                  } else {
                                    CartPage.cartItems.removeAt(index);
                                  }
                                });
                              },
                            ),
                            Text('${product['quantity']}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  product['quantity'] += 1;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  CartPage.cartItems.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: \$${calculateTotalPrice().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: PaymentPage.hasCreditCard
                            ? () {
                                Navigator.pushReplacementNamed(
                                    context, 'Order');
                                OrderPage.addToOrder(CartPage.cartItems);
                                CartPage.cartItems.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Purchase successful!'),
                                  ),
                                );
                              }
                            : null,
                        child: Text('Comprar'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: NavigationBarCustom(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
