import 'package:flutter/material.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({ Key? key }) : super(key: key);

  @override
  _OCRScreenState createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMAGE TO TEXT"),
      ),
      body: Center(
        child: Text(" ")
      ),
    );
  }

}