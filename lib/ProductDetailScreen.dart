import 'package:flutter/material.dart';
import 'cart_page.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  const ProductDetailScreen({
    super.key, 
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                imageUrl,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$$price',
              style: const TextStyle(
                fontSize: 26,
                color: Color.fromARGB(255, 0, 255, 0),
                fontWeight: FontWeight.bold, 
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: Colors.grey[800],
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromRGBO(30, 30, 30, 1),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  CartPage.addToCart({
                    'title': title,
                    'imageUrl': imageUrl,
                    'price': price,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to cart', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black,
                    ),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
