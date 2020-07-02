import 'package:razor_demo/ProductPage.dart';
import 'package:flutter/material.dart';
import 'package:razor_demo/PaymentsPage.dart';
import 'package:razor_demo/ResultPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final arguments = settings.arguments;

    switch(settings.name){
      case '/payments':
        return MaterialPageRoute(builder: (_) => PaymentsPage(newProduct: arguments));
      case '/result':
        return MaterialPageRoute(builder: (_) => ResultPage(payDeet: arguments));
      default:
        return MaterialPageRoute(builder: (_) => ProductPage());
    }
  }
}