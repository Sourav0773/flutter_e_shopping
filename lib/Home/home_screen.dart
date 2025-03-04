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
      body: SingleChildScrollView(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Categories(categoryimageURL: 'https://prabhubhakti.in/wp-content/uploads/2023/02/Best-motivational-quotes-with-designed-printed-t-shirt-for-men.jpg', categoryName: 'T-shirts'), SizedBox(width: 30),
                    Categories(categoryimageURL: 'https://th.bing.com/th/id/OIP.8QNYHsDDw5BYXc2GjsxisAHaJQ?w=208&h=260&c=7&r=0&o=5&dpr=1.3&pid=1.7', categoryName: 'Jeans'), SizedBox(width: 30),
                    Categories(categoryimageURL: 'https://th.bing.com/th/id/OIP.Chop318pkHjWLSrNEf-ZrgHaJ4?w=208&h=277&c=7&r=0&o=5&dpr=1.3&pid=1.7', categoryName: 'Hoddies'), SizedBox(width: 30),
                    Categories(categoryimageURL: 'https://th.bing.com/th/id/OIP.z8fqdOzefKSqNReKoGxGogHaHa?w=159&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', categoryName: 'Shoes'), SizedBox(width: 30),
                    Categories(categoryimageURL: 'https://th.bing.com/th/id/OIP.LCnfmwqTYUiCQleTvRrVBgHaCY?w=332&h=112&c=7&r=0&o=5&dpr=1.3&pid=1.7', categoryName: 'Accessories'), SizedBox(width: 30),
                    Categories(categoryimageURL: 'https://th.bing.com/th/id/OIP.BzPtEqzTX3LUHAEYNQlEoQHaHa?w=186&h=187&c=7&r=0&o=5&dpr=1.3&pid=1.7', categoryName: 'Bag'), SizedBox(width: 30),
                    Categories(categoryimageURL: 'https://th.bing.com/th/id/OIP.W4P-QoQr6luJ1qdqpLQaOwHaKC?w=208&h=282&c=7&r=0&o=5&dpr=1.3&pid=1.7', categoryName: 'Saree'), SizedBox(width: 30),
                    ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Top Selling',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20),
              Text('data')
            ],
          ),
        ),
      ),
    );
  }
}


/////category cirle widget/////////////
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
    return Column(
      children: [
      CircleAvatar(
        backgroundImage: NetworkImage(widget.categoryimageURL),
        radius: 40,
      ),
      const SizedBox(height: 10),
      Text(
        widget.categoryName,
        style: TextStyle(
          fontSize: 13,
          color: Colors.black
        ),
      )
    ]);
  }
}
