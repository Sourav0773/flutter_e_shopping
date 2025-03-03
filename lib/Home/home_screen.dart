import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /////////////////////////////////
  String? selectedCategory;
  final List<String> categories = [
    "Men",
    "Women",
    "Children",
    "Newborn",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                            hint: const Text(
                              "Category",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
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
                            })),
                  ),
                ),

                ///bag icon button////
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color.fromARGB(255, 153, 123, 237),
                  child: IconButton(
                    onPressed: () {},
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
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.search_outlined, color: Colors.black),
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.only(left: -5),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}


