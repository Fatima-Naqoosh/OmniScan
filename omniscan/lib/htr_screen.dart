import 'package:flutter/material.dart';

class HTRScreen extends StatefulWidget {
  const HTRScreen({ Key? key }) : super(key: key);

  @override
  _HTRScreenState createState() => _HTRScreenState();
}

class _HTRScreenState extends State<HTRScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Handwriting to Text"),
      ),
      body: Center(
        child: Text(" ")
      ),
    );
  }

}