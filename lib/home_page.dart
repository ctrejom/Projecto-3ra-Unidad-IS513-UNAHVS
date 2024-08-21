import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/Widgets/NavigationBarCustom.dart';
import 'ProductDetailScreen.dart';
import 'category_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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

  void filterProductsBySearchQuery(String query) {
    setState(() {
      filteredProducts = products.where((product) {
        return product['title'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text('Home Page',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w100)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                leading: const Icon(Icons.search, color: Colors.white),
                hintText: 'Search',
                hintStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
                textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
                onSubmitted: (value) {
                  if (value.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid term.'),
                      ),
                    );
                    return;
                  }
                  filterProductsBySearchQuery(value);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                        searchQuery: value,
                        searchResults: filteredProducts,
                      ),
                    ),
                  ).then((_) {
                    setState(() {
                      filteredProducts = products;
                    });
                  });
                },
                backgroundColor:
                    WidgetStateProperty.all(Color.fromRGBO(30, 30, 30, 1)),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        final categoryProducts = products.where((product) {
                          return product['category'] == 'men\'s clothing';
                        }).toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryGridPage(
                              products: categoryProducts,
                              categoryName: 'men\'s clothing',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'men\'s clothing'
                            ? Colors.blue
                            : const Color.fromRGBO(30, 30, 30, 1),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon:
                          const Icon(Icons.male, size: 30, color: Colors.blue),
                      label: const Text('Men\'s clothing',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        final categoryProducts = products.where((product) {
                          return product['category'] == 'jewelery';
                        }).toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryGridPage(
                              products: categoryProducts,
                              categoryName: 'Jewelry',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'jewelery'
                            ? Colors.blue
                            : const Color.fromRGBO(30, 30, 30, 1),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      icon: const Icon(Icons.watch,
                          size: 30, color: Colors.purple),
                      label: const Text('Jewelry'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        final categoryProducts = products.where((product) {
                          return product['category'] == 'electronics';
                        }).toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryGridPage(
                              products: categoryProducts,
                              categoryName: 'Electronics',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'electronics'
                            ? Colors.blue
                            : const Color.fromRGBO(30, 30, 30, 1),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.electrical_services,
                          size: 30, color: Colors.orange),
                      label: const Text('Electronics'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        final categoryProducts = products.where((product) {
                          return product['category'] == 'women\'s clothing';
                        }).toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryGridPage(
                              products: categoryProducts,
                              categoryName: 'Women\'s Clothing',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'women\'s clothing'
                            ? Colors.blue
                            : const Color.fromRGBO(30, 30, 30, 1),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.female,
                          size: 30, color: Colors.pink),
                      label: const Text('Women\'s Clothing'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Recomended For You',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              filteredProducts.isEmpty
                  ? const Center(child: CircularProgressIndicator())
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
                              margin: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      product['image'],
                                      height: 170,
                                      width: 170,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    product['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${product['price']}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              const SizedBox(height: 10),
              const Text(
                'Best For You',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
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
                              margin: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      product['image'],
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    product['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${product['price']}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(),
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
