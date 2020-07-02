import 'package:flutter/material.dart';

class AddDetails extends StatefulWidget{

  @override
  createState() => AddDetailsState();
}

class AddDetailsState extends State<AddDetails>{



  @override
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details")
      ),
      body: Center(
        child: Column(
          children: [
            TextField(

            )
          ]
        )
      )
    )  ;
  }
}