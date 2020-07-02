import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget{

  @override
  createState() => ProductPageState();
}

class Product {
  final String prodName;
  final int prodCost;

  Product({this.prodName, this.prodCost});

}

class ProductPageState extends State<ProductPage>{

  List<Product> prodList;
  List<String> prodNames = ['T-Shirt', 'iPhone SE','Flutter Goodie', 'Cat Litter', 'Postage Stamps'];

  @override
  void initState() {
    super.initState();
    prodList = prodNames.map((e) => Product(prodName:e, prodCost:100)).toList();
  }

  Widget productCard(Product prod){
    return Card(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${prod.prodName}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${prod.prodCost}"),
                  RaisedButton(
                    child: Text("Buy"),
                    onPressed: () => Navigator.of(context).pushNamed(
                      '/payments',
                      arguments: prod
                    ),
                  )
                ]
              )
            ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text("Products Page")),
        backgroundColor: Colors.transparent
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        children: prodList.map((e) => productCard(e)).toList(),
      )
    );
  }
}