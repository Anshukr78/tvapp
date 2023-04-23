class ProductClass{
  String id;
  String productName;
  int productPrice;
  String productDescrition;
  String brand;
  int qty =1;
  List size;
  String category;
  String imageUrl;

  ProductClass({
    required this.imageUrl,
    required this.productPrice,
    required this.size,
    required this.brand,
    required this.category,
    required this.qty,
    required this.id,
    required this.productDescrition,
    required this.productName,
  });

  void increase(){
    qty++;
  }
  void decrease(){
    qty--;
  }
}