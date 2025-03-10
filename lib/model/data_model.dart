class Products {
  final int pid;        
  final String pname;   
  final String pdescription;  
  final String? image;   
  final String pcat;
  late String imageUrl = 'https://th.bing.com/th/id/OIP.uuMtMWi1k_j4VkF6kFsVkAHaL2?w=121&h=194&c=7&r=0&o=5&dpr=1.3&pid=1.7';
  int price = 999;    

  Products({
    required this.pid,
    required this.pname,
    required this.pdescription,
    required this.image,
    required this.pcat,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
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
