import 'package:e_shopping_app/API/api_service.dart';
import 'package:e_shopping_app/Description/description_screen.dart';
import 'package:e_shopping_app/Model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:e_shopping_app/Provider/provider.dart';
import 'package:e_shopping_app/Cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  final List<String> categories = [
    "TEST1", //MEN
    "TEST2", //WOMEN
    "TEST3", //CHILDREN
    "TEST4", //NEWBORN
    "TEST5" //OTHERS
  ];
  TextEditingController searchController = TextEditingController();
  List<Products> searchFilteredProducts = [];
  late Future<List<Products>> productFuture;
  List<Products> cart = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // ignore: use_build_context_synchronously
      Provider.of<CartModel>(context, listen: false).startSkeletonLoader();
    });
    productFuture = ApiService().fetchProductData();
  }

  void filterProductsById(String query) {
    if (query.isEmpty) {
      setState(() {
        searchFilteredProducts = [];
      });
      return;
    }
    productFuture.then((products) {
      List<Products> filteredList = [];
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

  //body parts///////////
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cartModel, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () => cartModel.startSkeletonLoader(),
          child: Skeletonizer(
            enabled: cartModel.skeletonloader,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //////top row///////////////////
                  const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            "https://dp-pic.com/wp-content/uploads/2024/07/a-handsome-man-in-dark-with-hidden-face-boys-attitude-dp-by-dp-pic-2-768x768.jpg"),
                      ),

                      ///dropdown menu container///////
                      Container(
                        height: 48,
                        width: 140,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 240, 240),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: selectedCategory,
                              hint: const Text("Category"),
                              items: categories.map((String category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCategory = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      ///bag icon button////
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
                    ],
                  ),

                  ///search bar//////////////
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
                            child: Icon(Icons.search_outlined,
                                color: Colors.black),
                          ),
                          hintText: 'Search by PID or PNAME',
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.only(left: -5),
                        ),
                        onChanged: (value) {
                          filterProductsById(value);
                        }),
                  ),

                  ///////////////////////////////////////////////////////////
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Categories(
                            categoryimageURL:
                                'https://prabhubhakti.in/wp-content/uploads/2023/02/Best-motivational-quotes-with-designed-printed-t-shirt-for-men.jpg',
                            categoryName: 'T-shirts'),
                        SizedBox(width: 30),
                        Categories(
                            categoryimageURL:
                                'https://th.bing.com/th/id/OIP.8QNYHsDDw5BYXc2GjsxisAHaJQ?w=208&h=260&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                            categoryName: 'Jeans'),
                        SizedBox(width: 30),
                        Categories(
                            categoryimageURL:
                                'https://th.bing.com/th/id/OIP.Chop318pkHjWLSrNEf-ZrgHaJ4?w=208&h=277&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                            categoryName: 'Hoddies'),
                        SizedBox(width: 30),
                        Categories(
                            categoryimageURL:
                                'https://th.bing.com/th/id/OIP.z8fqdOzefKSqNReKoGxGogHaHa?w=159&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                            categoryName: 'Shoes'),
                        SizedBox(width: 30),
                        Categories(
                            categoryimageURL:
                                'https://th.bing.com/th/id/OIP.LCnfmwqTYUiCQleTvRrVBgHaCY?w=332&h=112&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                            categoryName: 'Accessories'),
                        SizedBox(width: 30),
                        Categories(
                            categoryimageURL:
                                'https://th.bing.com/th/id/OIP.BzPtEqzTX3LUHAEYNQlEoQHaHa?w=186&h=187&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                            categoryName: 'Bag'),
                        SizedBox(width: 30),
                        Categories(
                            categoryimageURL:
                                'https://th.bing.com/th/id/OIP.W4P-QoQr6luJ1qdqpLQaOwHaKC?w=208&h=282&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                            categoryName: 'Saree'),
                        const SizedBox(width: 30),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'All Products',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 15),
                  searchFilteredProducts.isEmpty &&
                          searchController.text.isNotEmpty
                      ? Column(
                          children: [
                            Image.asset('assets/images/nodata.png'),
                            const Text(
                              'No data found!!!👀',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        )
                      : Expanded(
                          child: FutureBuilder<List<Products>>(
                            future: productFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(child: const Text(''));
                              } else {
                                var products = snapshot.data!;
                                var displayProducts =
                                    searchFilteredProducts.isEmpty
                                        ? products
                                        : searchFilteredProducts;

                                return ListView.builder(
                                  itemCount: displayProducts.length,
                                  itemBuilder: (context, index) {
                                    var product = displayProducts[index];
                                    return Stack(
                                      children: [
                                        Container(
                                          height: 150,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 229, 226, 226),
                                            border: Border.all(
                                                color: Colors.white, width: 5),
                                          ),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartModel
                                                      .selectProduct(product);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DescriptionScreen()),
                                                  );
                                                },
                                                child: Image.network(
                                                  product.imageUrl,
                                                ),
                                              ),
                                              const VerticalDivider(
                                                color: Colors.white,
                                                width: 1,
                                                thickness: 6,
                                              ),
                                              const SizedBox(width: 50),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 30),
                                                  Text(
                                                    'PID: ${product.pid}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'PNAME: ${product.pname}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'PRICE: Rs.${product.price}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        //add to cart/////
                                        Positioned(
                                          top: 3,
                                          left: 340,
                                          child: IconButton(
                                            onPressed: () =>
                                                cartModel.addToCart(product),
                                            icon: Center(
                                              child: const Icon(
                                                Icons.shopping_bag_outlined,
                                                color: Color.fromARGB(
                                                    255, 126, 83, 244),
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
                                                color: Color.fromARGB(
                                                    255, 126, 83, 244),
                                              ),
                                            )),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

///////////////////////////////////////////////////////////////////////////////
///category circle widget/////////////
class Categories extends StatefulWidget {
  final String categoryimageURL;
  final String categoryName;

  const Categories(
      {super.key, required this.categoryimageURL, required this.categoryName});

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        backgroundImage: NetworkImage(widget.categoryimageURL),
        radius: 40,
      ),
      const SizedBox(height: 10),
      Text(
        widget.categoryName,
        style: TextStyle(fontSize: 13, color: Colors.black),
      )
    ]);
  }
}
