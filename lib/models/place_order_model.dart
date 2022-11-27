import 'dart:convert';

import 'package:fooddeliveryapp/models/cart_model.dart';
import 'package:fooddeliveryapp/models/place_order_model.dart';
import 'package:intl/intl.dart';

class PlaceOrderBody {
  List<CartModel>? _cart;
  late double _orderAmount;
  late String _orderNote;
  late double _distance;
  late String _address;
  late String _latitude;
  late String _longitude;
  late String _contactPersonName;
  late String _contactPersonNumber;
  late String _orderType;
  late String _paymentMethod;

  PlaceOrderBody(
      {required List<CartModel> cart,
      required double orderAmount,
      required String orderNote,
      required double distance,
      required String address,
      required String latitude,
      required String longitude,
      required String contactPersonName,
      required String contactPersonNumber,
      required String orderType,
      required String paymentMethod,
     }) {

    this._cart = cart;
    this._orderAmount = orderAmount;
    this._distance = distance;
    this._orderNote = orderNote;
    this._address = address;
    this._latitude = latitude;
    this._longitude = longitude;
    this._contactPersonName = contactPersonName;
    this._contactPersonNumber = contactPersonNumber;
    this._orderType=orderType;
    this._paymentMethod=paymentMethod;
  }

  List<CartModel> get cart => _cart!;

  double get orderAmount => _orderAmount;

  String get orderNote => _orderNote;

  double get distance => _distance;

  String get address => _address;

  String get latitude => _latitude;

  String get longitude => _longitude;

  String get contactPersonName => _contactPersonName;

  String get contactPersonNumber => _contactPersonNumber;

  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart!.add(new CartModel.fromJson(v));
      });
    }

    _cart = json['cart'];
    _orderAmount = json['orderAmount'];
    _orderNote = json['orderNote'];
    _distance = json['distance'];
    _address = json['address'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _contactPersonNumber = json['contactPersonNumber'];
    _contactPersonName = json['contactPersonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._cart != null) {
      data['cart'] = this._cart!.map((v) => v.toJson()).toList();
    }
    data['order_amount'] = this._orderAmount;
    data['order_note'] = this._orderNote;
    data['distance'] = this._distance;
    data['address'] = this._address;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['contact_PersonNumber'] = this._contactPersonNumber;
    data['order_type']=this._orderType;
    data['payment_method']=this._paymentMethod;
    return data;
  }
}
