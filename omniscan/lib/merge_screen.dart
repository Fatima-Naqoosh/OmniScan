import 'package:flutter/material.dart';

class MergeScreen extends StatefulWidget {
  const MergeScreen({ Key? key }) : super(key: key);

  @override
  _MergeScreenState createState() => _MergeScreenState();
}

class _MergeScreenState extends State<MergeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Merge Document"),
      ),
      body: Center(
        child: Text(" ")
      ),
    );
  }

}