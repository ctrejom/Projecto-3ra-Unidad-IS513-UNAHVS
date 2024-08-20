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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
         title: Text('Cart', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30, fontWeight: FontWeight.w100)),
      ),
      body: CartPage.cartItems.isEmpty
          ? Center(child: Text('No items in the cart', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30, fontWeight: FontWeight.w100)))
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
                        title: Text(product['title'], style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
                        subtitle: Text(style: TextStyle(color: Color.fromARGB(255, 22, 255, 1)),
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
                          fontWeight: FontWeight.bold, color: Colors.white
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
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
                        child: Text('Buy Now'),
                        
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
