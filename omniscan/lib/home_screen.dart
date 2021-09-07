import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> values = ['assets/images/scanner.jpg', 'assets/images/merge.jpg', 'assets/images/compress.jpg', 'assets/images/bg_change.jpg', 'assets/images/ocr.jpg', 'assets/images/htr.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OmniScan"),
      ),
      body: Container(

        child: GridView.builder (
          itemCount: 6,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: Center(
                child: Image.asset(values[index]),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        )
      )
      
    );
  }
}
