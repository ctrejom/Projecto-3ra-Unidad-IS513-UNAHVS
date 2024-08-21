import 'package:flutter/material.dart';
import 'ProductDetailScreen.dart';

class CategoryGridPage extends StatelessWidget {
  final List<dynamic> products;
  final String categoryName;

  const CategoryGridPage({super.key, required this.products, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Fondo oscuro
      appBar: AppBar(
        title: Text(categoryName, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 10, 10, 10), // Fondo de la AppBar oscuro
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      title: product['title'],
                      imageUrl: product['image'],
                      price: product['price'],
                      description: product['description'],
                    ),
                  ),
                );
              },
              child: Card(
                color: const Color.fromARGB(255, 20, 20, 20), // Fondo oscuro para la tarjeta
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        product['image'],
                        height: 100,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // Texto en blanco
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$${product['price']}',
                            style: const TextStyle(fontSize: 14, color: Colors.green), // Precio en verde
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
