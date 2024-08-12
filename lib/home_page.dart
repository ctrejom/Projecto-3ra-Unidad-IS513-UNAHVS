import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/Widgets/NavigationBarCustom.dart';
import 'ProductDetailScreen.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  String selectedCategory = '';

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
            'description': product['description'] ?? 'No description available',
            'category': product['category'],
          };
        }).toList();
        filteredProducts = products;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  void filterProductsByCategory(String category) {
    setState(() {
      selectedCategory = category;
      filteredProducts = products.where((product) {
        return product['category'] == category;
      }).toList();
    });
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
              SearchBar(
                leading: Icon(Icons.search),
                hintText: 'Buscar',
                onChanged: (value) {
                  print('Texto de búsqueda: $value');
                },
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        filterProductsByCategory('men\'s clothing');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'men\'s clothing'
                            ? Colors.blue
                            : Colors.grey[200],
                        foregroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(Icons.male, size: 30, color: Colors.blue),
                      label: Text('Ropa de Hombre'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        filterProductsByCategory('jewelery');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'jewelery'
                            ? Colors.blue
                            : Colors.grey[200],
                        foregroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(Icons.watch, size: 30, color: Colors.purple),
                      label: Text('Joyeria'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        filterProductsByCategory('electronics');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'electronics'
                            ? Colors.blue
                            : Colors.grey[200],
                        foregroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(Icons.electrical_services,
                          size: 30, color: Colors.orange),
                      label: Text('Electrónicos'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        filterProductsByCategory('women\'s clothing');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'women\'s clothing'
                            ? Colors.blue
                            : Colors.grey[200],
                        foregroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(Icons.female, size: 30, color: Colors.pink),
                      label: Text('Ropa de Mujer'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Top Sellers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              filteredProducts.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: filteredProducts.take(5).map((product) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    title: product['title'],
                                    imageUrl: product['image'],
                                    description: product['description'],
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
              filteredProducts.length > 5
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: filteredProducts.skip(5).map((product) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    title: product['title'],
                                    imageUrl: product['image'],
                                    description: product['description'],
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
