import 'package:flutter/material.dart';

class Product {
  final String name;
  final String rating;
  final int price;
  final String imageUrl;

  const Product({
    required this.name,
    required this.rating,
    required this.price,
    required this.imageUrl,
  });
}

class ProductDisplayWidget extends StatelessWidget {
  final Product product;

  const ProductDisplayWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Left side: Image
        Image.network(product.imageUrl, width: 100, height: 100),
        const SizedBox(width: 10),
        Expanded(
          // Allows text to take available space
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Align text to left
            children: <Widget>[
              Text(product.name),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star, size: 16),
                      Text(product.rating),
                    ],
                  ),
                  Text('${product.price} Rs'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Product rice = Product(
    name: "Rice and fishes Platter",
    rating: "4.5",
    price: 950,
    imageUrl: "",
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Product Display')),
        body: Center(child: ProductDisplayWidget(product: rice)),
      ),
    );
  }
}
