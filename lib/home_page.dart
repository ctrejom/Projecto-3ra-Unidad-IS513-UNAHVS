import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_screen.dart'; // Import the new screen
import 'Widgets/NavigationBarCustom.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushNamed(context, 'Home');
          break;
        case 1:
          Navigator.pushNamed(context, 'Order');
          break;
        case 2:
          Navigator.pushNamed(context, 'Cart');
          break;
        case 3:
          Navigator.pushNamed(context, 'Payment');
          break;
      }
    });
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body).map((product) {
          return {
            'title': product['title'],
            'image': product['image'],
            'price': product['price'] is int
                ? (product['price'] as int).toDouble()
                : product['price'],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Existing SearchBar and category buttons

              SizedBox(height: 10),
              Text(
                'Top Sellers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              products.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: products.take(5).map((product) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    title: product['title'],
                                    imageUrl: product['image'],
                                    price: product['price'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              margin: EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product['image'],
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    product['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '\$${product['price']}',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              SizedBox(height: 10),
              Text(
                'Best For You UwU',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              products.length > 5
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: products.skip(5).map((product) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    title: product['title'],
                                    imageUrl: product['image'],
                                    price: product['price'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              margin: EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product['image'],
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    product['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '\$${product['price']}',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Center(child: Text('No more products available')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarCustom(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
