import 'package:e_shopping_app/API/api_service.dart';
import 'package:e_shopping_app/Screens/category_screen.dart';
import 'package:e_shopping_app/Screens/description_screen.dart';
import 'package:e_shopping_app/Model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:e_shopping_app/Provider/cartmodel_provider.dart';
import 'package:e_shopping_app/Screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  TextEditingController searchController = TextEditingController();
  List<Products> searchFilteredProducts = [];
  List<Products> filteredList = [];
  late Future<List<Products>> productFuture;
  bool isLoading = false;

  late ScrollController controller;
  List<Products> allFetchedProducts = [];
  List<Products> productsLoadedInitially = [];
  int initialProductsLoaded = 10;
  int totalProductCount = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CartModel>(context, listen: false).startSkeletonLoader();
    });
    searchController = TextEditingController();
    productFuture = ApiService().fetchProductData();
    controller = ScrollController()..addListener(scrollListener);
  }

  /// Search filter based on PID and PNAME
  void filterProductsById(String query) {
     if (query.isEmpty) {
      setState(() {
        searchFilteredProducts = [];
      });
      return;
    }
    productFuture.then((products) {
      if (query.isEmpty) {
        setState(() {
          searchFilteredProducts = [];
        });
        return;
      }
      filteredList.clear();
      for (var product in products) {
        if (product.pid.toString().contains(query) || product.pname.toLowerCase().replaceAll(' ', '').contains(query)) {
          filteredList.add(product);
        }
      }
      setState(() {
        searchFilteredProducts = filteredList;
      });
    });
  }

  /// Load more products when the user scrolls
  Future loadMoreData() async {
    await Future.delayed(Duration(milliseconds: 2000)); 
    setState(() {
      if (allFetchedProducts.isNotEmpty) {
        initialProductsLoaded += 10;
      }
      isLoading = false;
    });
  }

  /// Scroll Listener to load more products
  void scrollListener() {
    if (controller.position.extentAfter < 100 && !isLoading) {
      setState(() {
        isLoading = true;
      });
      loadMoreData();
    }
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    //TextEditingController().dispose();
    super.dispose();
  }

  // Body parts
  @override
  Widget build(BuildContext context) {

    return Consumer<CartModel>(
      builder: (context, cartModel, child) {

        return Scaffold(
          backgroundColor: Colors.white,
          body: Skeletonizer(
            enabled: cartModel.skeletonloader,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/1667071/pexels-photo-1667071.jpeg?cs=srgb&dl=pexels-laryssa-suaid-798122-1667071.jpg&fm=jpg"),
                      ),

                      GestureDetector(
                        child: Container(
                          height: 48,
                          width: 140,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 242, 240, 240),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(4, 5),
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Category',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: const Color.fromARGB(
                                      255, 134, 134, 134)),
                            ),
                          ),
                        ),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CategoryScreen(),
                            ),
                          ),
                        },
                      ),
                      
                      Stack(
                        children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor:
                              const Color.fromARGB(255, 153, 123, 237),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen()),
                              );
                            },
                            icon: Center(
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 31,
                          bottom: 31,
                          child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 9,
                            child: Center(
                              child: Text(
                                '${cartModel.cartItems.length}',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),

                  const SizedBox(height: 30),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 242, 240, 240),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(
                                Icons.search_outlined,
                                color: Colors.black
                              ),
                          ),
                          hintText: 'Search by PID or PNAME',
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.only(left: -5),
                        ),
                        onChanged: (value) {
                          filterProductsById(value);
                        }),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'All Products',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),

                  const SizedBox(height: 15),
                  searchController.text.isNotEmpty && searchFilteredProducts.isEmpty
                      ? Column(
                          children: [
                            Image.asset('assets/images/nodata.png'),
                            const Text(
                              'No data found!!!👀',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: FutureBuilder<List<Products>>(
                            future: productFuture,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(
                                    child: Text("No data found!!"));
                              } else {
                                allFetchedProducts = snapshot.data!;
                                productsLoadedInitially = allFetchedProducts.take(initialProductsLoaded).toList();
          
                                List<Products> displayProducts = searchFilteredProducts.isEmpty ? productsLoadedInitially : searchFilteredProducts;
          
                                return Scrollbar(
                                  child: ListView.builder(
                                    controller: controller,
                                    itemCount: displayProducts.length + (isLoading ? 1 : 0),
                                    itemBuilder: (BuildContext context, int index) {
                                      if (index == displayProducts.length) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        // Product cards
                                        return ProductCard(product: displayProducts[index]);
                                      }
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Product Card
class ProductCard extends StatelessWidget {

  final dynamic product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {

    return Consumer<CartModel>(
      builder: (context, cartModel, child) {

      return Stack(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 229, 226, 226),
              border: Border.all(color: Colors.white, width: 5),
            ),

            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    cartModel.selectProduct(product);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DescriptionScreen()
                        ),
                    );
                  },
                  child: Image.network(product.imageUrl),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'PNAME: ${product.pname}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'PRICE: Rs.${product.price}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: 3,
            left: 340,
            child: IconButton(
              onPressed: () => cartModel.addToCart(product),
              icon: Center(
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Color.fromARGB(255, 126, 83, 244),
                  size: 34,
                ),
              ),
            ),
          ),
          
          Positioned(
            top: 20,
            left: 360,
            child: const Text(
              '+',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 126, 83, 244),
              ),
            ),
          ),
        ],
      );
    });
  }
}
