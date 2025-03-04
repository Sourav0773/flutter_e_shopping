class Product {
  final int pid;        
  final String pname;   
  final String pdescription;  
  final String? image;   
  final String pcat;    

  Product({
    required this.pid,
    required this.pname,
    required this.pdescription,
    this.image,
    required this.pcat,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      pid: json['PID'],
      pname: json['PNAME'],
      pdescription: json['PDESCRIPTION'],
      image: json['Image'],
      pcat: json['PCAT'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PID': pid,
      'PNAME': pname,
      'PDESCRIPTION': pdescription,
      'Image': image,
      'PCAT': pcat,
    };
  }
}
