import 'package:e_shopping_app/API/api_service.dart';
import 'package:e_shopping_app/Model/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:e_shopping_app/Screens/home_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Initial states for checkboxes
  bool cat1 = false;
  bool cat2 = false;
  bool cat3 = false;
  bool cat4 = false;
  bool cat5 = false;

  List<Products> filteredProducts = [];
  List<String> selectedCategories = [];
  bool isLoading = false;

  // Fetch data when checkbox is selected or removee when deselected
  Future fetchData(String category, bool isSelected) async {
    setState(() {
      isLoading = true; 
    });
    try {
      var fetchedProducts = await ApiService().fetchProductData();
      setState(() {
        if (isSelected) {
          if (!selectedCategories.contains(category)) {
            selectedCategories.add(category);
          }
        } else {
          selectedCategories.remove(category);
        }
        filteredProducts = fetchedProducts.where((product) {
          return selectedCategories.contains(product.pcat);
        }).toList();
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
    } finally {
      setState(() {
        isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Products'),
      ),

      drawer: Drawer(
        backgroundColor:const Color.fromARGB(255, 176, 8, 206).withOpacity(0.1),
        shape: Border(bottom: BorderSide.none),

        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              const SizedBox(height: 35),
              const Text(
                'Filter Options',
                style: TextStyle(color: Colors.white, fontSize: 27),
              ),

              const SizedBox(height: 15),
              CheckboxListTile(
                title: const Text(
                  "Category 1",
                  style: TextStyle(color: Colors.white),
                ),
                value: cat1,
                onChanged: (bool? value) {
                  setState(() {
                    cat1 = value!;
                    fetchData('CAT1', cat1);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              
              const SizedBox(height: 15),
              CheckboxListTile(
                title: const Text(
                  "Category 2",
                  style: TextStyle(color: Colors.white),
                ),
                value: cat2,
                onChanged: (bool? value) {
                  setState(() {
                    cat2 = value!;
                    fetchData('CAT2', cat2);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              const SizedBox(height: 15),
              CheckboxListTile(
                title: const Text(
                  "Category 3",
                  style: TextStyle(color: Colors.white),
                ),
                value: cat3,
                onChanged: (bool? value) {
                  setState(() {
                    cat3 = value!;
                    fetchData('CAT3', cat3);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              const SizedBox(height: 15),
              CheckboxListTile(
                title: const Text(
                  "Category 4",
                  style: TextStyle(color: Colors.white),
                ),
                value: cat4,
                onChanged: (bool? value) {
                  setState(() {
                    cat4 = value!;
                    fetchData('CAT4', cat4);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              SizedBox(height: 15),
              CheckboxListTile(
                title: const Text(
                  "Category 5",
                  style: TextStyle(color: Colors.white),
                ),
                value: cat5,
                onChanged: (bool? value) {
                  setState(() {
                    cat5 = value!;
                    fetchData('CAT5', cat5);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : filteredProducts.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 250),
                      const Icon(Icons.warning_rounded, color: Colors.red, size: 100),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 105),
                        child: const Text(
                          'Please select categories from Filter Options from the above menu bar to view filtered products.',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    //ProductCard widget reused from home_screen
                    return ProductCard(product: filteredProducts[index]);
                  },
                ),
    );
  }
}
