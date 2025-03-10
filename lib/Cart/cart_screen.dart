import 'package:e_shopping_app/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Consumer<CartModel>(
        builder: (context, cartModel, child) {
          return cartModel.cartItems.isEmpty
              ? emptyCart()
              : cartWithItems(cartModel);
        },
      ),
    );
  }

  ///Empty Cart Screen//
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
              Navigator.pop(context);
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

  ///Cart with Items/////////////////////////
  Widget cartWithItems(CartModel cartModel) {
    return RefreshIndicator(
      onRefresh: () => cartModel.startSkeletonLoader(),
      child: Skeletonizer(
        enabled: cartModel.skeletonloader,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartModel.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartModel.cartItems[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(children: [
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 229, 226, 226),
                          border: Border.all(color: Colors.white, width: 5),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              product.imageUrl,
                            ),
                            const VerticalDivider(
                              color: Colors.white,
                              width: 1,
                              thickness: 6,
                            ),
                            const SizedBox(width: 50),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                Text(
                                  'PID: ${product.pid}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'PNAME: ${product.pname}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'PRICE: ${product.price}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //remove from cart/////
                      Positioned(
                        top: 3,
                        left: 340,
                        child: IconButton(
                          onPressed: () => cartModel.removeFromCart(product),
                          icon: Center(
                            child: const Icon(
                              Icons.delete_forever_outlined,
                              color: Color.fromARGB(255, 126, 83, 244),
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: Text(
                'Total Price: Rs.${cartModel.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
