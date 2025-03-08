import 'package:e_shopping_app/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_shopping_app/model/data_model.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;

  const CartPage({
    super.key, 
    required this.cartItems
  });

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.cartItems.isEmpty ? emptyCart() : cartWithItems(),
    );
  }

  // Empty Cart 
  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/emptycart.png'),
          const SizedBox(height: 20),
          const Text(
            'Your cart is empty!!!👻',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 163, 136, 237),
              ),
              elevation: MaterialStateProperty.all(10.0),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: const Text(
              'Explore more items 😀',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  // Cart with Items
  Widget cartWithItems() {
    return ListView.builder(
      itemCount: widget.cartItems.length,
      itemBuilder: (context, index) {
        final product = widget.cartItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 5,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Image.network(product.imageUrl, width: 60, height: 60),
            title: Text(
              product.pname,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("\$${product.price}"),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                setState(() {
                  widget.cartItems.removeAt(index);  // Remove item from cart
                });
              },
            ),
          ),
        );
      },
    );
  }
}
