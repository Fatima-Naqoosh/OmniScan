import 'package:flutter/material.dart';

class ChangeBGScreen extends StatefulWidget {
  const ChangeBGScreen({ Key? key }) : super(key: key);

  @override
  _ChangeBGScreenState createState() => _ChangeBGScreenState();
}

class _ChangeBGScreenState extends State<ChangeBGScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Image Background"),
      ),
      body: Center(
        child: Text(" ")
      ),
    );
  }

}