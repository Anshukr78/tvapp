import 'package:flutter/cupertino.dart';
import 'package:harbour_ecommerce/model/product.dart';

class Cart extends ChangeNotifier{

  final List<ProductClass> _list =[];

  List<ProductClass> get getItems{
    return _list;
  }

  double get totalPrice{
    var total = 0.0;

    for(var item in _list){
      total += item.productPrice * item.qty;
    }
    return total;
  }

  int? get count{
    return _list.length;
  }

  void addProduct({
    required String id,
    required String productName,
    required int productPrice,
    required int qty,
    required String brand,
    required String productUrl,
    required String category,
    required String productDescrition,
    required List size,
  }){
    final product = ProductClass(
        imageUrl: productUrl,
        productPrice: productPrice,
        size: size,
        brand: brand,
        category: category,
        qty: qty,
        id: id,
        productDescrition: productDescrition,
        productName: productName
    );
    _list.add(product);
    notifyListeners();
  }


  void increment(ProductClass product) {
    product.increase();
    notifyListeners();
  }

  void reduceByOne(ProductClass product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(ProductClass product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }

}