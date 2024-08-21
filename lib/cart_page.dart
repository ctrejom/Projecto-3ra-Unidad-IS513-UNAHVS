import 'package:flutter/material.dart';
import 'Widgets/NavigationBarCustom.dart';
import 'order_page.dart';
import 'payment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

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
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: CartPage.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: CartPage.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = CartPage.cartItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(30, 30, 30, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product['imageUrl'],
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${product['price']} x ${product['quantity']} = \$${(product['price'] * product['quantity']).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline,
                                      color: Colors.redAccent),
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
                                Text(
                                  '${product['quantity']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline,
                                      color: Colors.greenAccent),
                                  onPressed: () {
                                    setState(() {
                                      product['quantity'] += 1;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    setState(() {
                                      CartPage.cartItems.removeAt(index);
                                    });
                                  },
                                ),
                              ],
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
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(30, 30, 30, 1),
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: PaymentPage.hasCreditCard
                              ? () {
                                  Navigator.pushReplacementNamed(
                                      context, 'Order');
                                  OrderPage.addToOrder(CartPage.cartItems);
                                  CartPage.cartItems.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Purchase successful!'),
                                    ),
                                  );
                                }
                              : null,
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(color: Colors.white),
                          ),
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
