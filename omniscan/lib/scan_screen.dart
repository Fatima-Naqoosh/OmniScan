import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({ Key? key }) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Document"),
      ),
      body: Center(
        child: Text(" ")
      ),
    );
  }

}