
import 'package:fooddeliveryapp/models/product.dart';


class CartModel {
  CartModel({
    int? id,
    String? name,
    int? price,
    String? img,
    int? quantity,
    bool? isExit,
    String? time,
    ProductModel? product,

  }) {
     _name=name;
    _price = price;
    _img = img;
    _quantity = quantity;
    _isExist = isExit;
    _time = time;
    _product = product;
    _id = id;
  }

  CartModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _img = json['img'];
    _quantity = json['quantity'];
    _isExist = json['isExit'];
    _time = json['time'];
    _product=ProductModel.fromJson(json['product']);
 //   _product= json['product'];
  }

  int? _id;
  String? _name;
  int? _price;
  String? _img;
  int? _quantity;
  bool? _isExist;
  String? _time;
  ProductModel? _product;


  int? get id => _id;
  String? get name => _name;
  int? get price => _price;
  String? get img => _img;
  int? get quantity => _quantity;
  bool? get isExist => _isExist;
  String? get time => _time;
  ProductModel? get product => _product;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['img'] = _img;
    map['quantity'] = _quantity;
    map['isExist'] = _isExist;
    map['time'] = _time;
     map['product'] = _product;
   // 'product':this.product!.toJson();
    return map;
  }
}
