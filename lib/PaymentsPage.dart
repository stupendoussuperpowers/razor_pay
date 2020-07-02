import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'utils.dart';
import 'package:razor_demo/ProductPage.dart';
import 'package:async/async.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentsPage extends StatefulWidget{

    final Product newProduct;

    PaymentsPage({
      @required this.newProduct
    });

    @override
    createState() => PaymentsPageState(newProduct: newProduct);
}

class PaymentsPageState extends State<PaymentsPage>{

  Razorpay _razorpay;
  final Product newProduct;
  AsyncMemoizer _closeMemo = AsyncMemoizer();

  var newOrder;

  PaymentsPageState({
    @required this.newProduct
  });

  @override
  void initState(){
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handleSuccess(PaymentSuccessResponse resp){
    print("Success: ${resp.paymentId}");

    //API Call to store the payment/PaymentID etc. goes here....

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/result', ModalRoute.withName('/'),
        arguments: PaymentDetails(
            success: true, orderID: newOrder.orderID, cost: newOrder.cost
        )
    );
  }

  void _handleError(PaymentFailureResponse resp){

    //API call to store error goes here...

    print("Error: $resp");

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/result', ModalRoute.withName('/'),
        arguments: PaymentDetails(
            success: false, orderID: newOrder.orderID, cost: newOrder.cost
        )
    );

  }

  void _handleExternalWallet(ExternalWalletResponse resp){
    print("Wallet: $resp");
  }



  void openCheckout(var checkOutOptions){
    try {
      _razorpay.open(checkOutOptions);
    } catch(e){
      print(e);
    }
  }

  _fetchData() {
    return this._closeMemo.runOnce(() async {
      return await Utils.makeNewOrder(newProduct);
    });
  }

  Widget paymentCard(BuildContext context, Order order){
    return Container(
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('${newProduct.prodName}', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              Text('Order ID: ${order.orderID}', style: TextStyle(fontSize: 20),),
              Text('Cost: ${order.cost}', style: TextStyle(fontSize: 20)),
              RaisedButton(
                child: Text("Pay Using RazorPay"),
                onPressed: () {
                  setState((){
                    newOrder = order;
                  });
                  this.openCheckout({
                    'key' : '${DotEnv().env['API_KEY']}',
                    'amount': '${order.cost}',
                    'order_id': '${order.orderID}',
                    'name': 'sanchit_sahay',
                    'prefill': {
                      'contact': '5555555',
                      'email': 'john@doe.com'
                    }});
                }
              )
            ]
          ),
        )
      ),
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Make a Payment")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                print("${snapshot.data}");
                return paymentCard(context, snapshot.data);
              }
              else{
                return CircularProgressIndicator();
              }
            },
            future: this._fetchData()
            )
          ],
        )
      )
    );
  }
}