import 'package:e_shopping_app/Provider/cartmodel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cartModel, child) {
        final selectedProduct = cartModel.selectedProduct;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Description'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    selectedProduct.imageUrl,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'PNAME: ${selectedProduct.pname}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'PID: ${selectedProduct.pid}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 119, 119, 119),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price: Rs. ${selectedProduct.price}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Description: ${selectedProduct.pdescription}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
