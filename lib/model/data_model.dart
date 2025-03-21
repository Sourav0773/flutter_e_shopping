class Products {
  final int pid;        
  final String pname;   
  final String pdescription;  
  final String? image;   
  final String pcat;
  late String imageUrl = 'https://cdn.pixabay.com/photo/2024/02/25/15/50/product-display-stand-8596024_640.jpg';
  int price = 999;    

  //Constructor
  Products({
    required this.pid,
    required this.pname,
    required this.pdescription,
    required this.image,
    required this.pcat, required int price, required String imageUrl,
  });

  //Factory constructor to create Products from JSON
  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      pid: json['PID'],
      pname: json['PNAME'],
      pdescription: json['PDESCRIPTION'],
      image: json['Image'],
      pcat: json['PCAT'], 
      price: 999, 
      imageUrl: '',
    );
  }
}
