import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razor_demo/ProductPage.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Utils {

  static Future<Order> makeNewOrder(Product prod) async {

    print("Hello: ${DotEnv().env['API_KEY']}");
    try {
      var response =
      await http.post('https://${DotEnv().env['API_KEY']}:${DotEnv().env['KEY_SECRET']}@api.razorpay.com/v1/orders', headers: {
        "content-type": "application/json",
      },
          body: json.encode({
            "amount": prod.prodCost,
            "currency": "INR",
            "payment_capture": 1
          }));
      print(response.body);
      return Order.fromJson(json.decode(response.body));
    } catch(e){
      print(e);
    }
      return Order(orderID: "null", cost: 0);
  }

}

class Order{
  final String orderID;
  final int cost;

  Order({this.orderID, this.cost});

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(orderID: json['id'], cost: json['amount']);
  }
}

class PaymentDetails {
  final bool success;
  final String orderID;
  final int cost;

  PaymentDetails({
    @required this.success,
    @required this.orderID,
    @required this.cost
  });
}
