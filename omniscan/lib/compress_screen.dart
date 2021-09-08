import 'package:flutter/material.dart';

class CompressScreen extends StatefulWidget {
  const CompressScreen({ Key? key }) : super(key: key);

  @override
  _CompressScreenState createState() => _CompressScreenState();
}

class _CompressScreenState extends State<CompressScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compress Files"),
      ),
      body: Center(
        child: Text(" ")
      ),
    );
  }

}