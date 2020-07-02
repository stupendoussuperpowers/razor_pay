import 'package:flutter/material.dart';
import 'utils.dart';

class ResultPage extends StatelessWidget{

  final PaymentDetails payDeet;

  ResultPage({
    @required this.payDeet
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text( payDeet.success ? "Payment Successful" : "Error in making the Payment"),
      ),
      body: Center(
        child: Container(
          width: 550, child: Padding(
            padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                Icon( payDeet.success ? Icons.check : Icons.error_outline ,color: Colors.green, size: 55),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text("Order ID: ${payDeet.orderID}", style: TextStyle(fontSize: 20)),
                      Text("Amount Paid: ${payDeet.cost}", style: TextStyle(fontSize: 20)),
                      Text("Successfully paid via RazorPay")
                      ]), 
                RaisedButton(child: Text("Okay. Go Home"),
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)
                )
              ]
            ),
          )
        )
      )
    );
  }

}