import 'package:flutter/material.dart';
import 'merge_screen.dart';
import 'compress_screen.dart';
import 'changebg_screen.dart';
import 'ocr_screen.dart';
import 'htr_screen.dart';
// ignore: unused_import
import 'scan_screen.dart';
// ignore: unused_import
import 'package:camera/camera.dart';
// ignore: unused_import
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> events = [
    "Scan",
    "Merge PDF",
    "Compress",
    "Change Image Background",
    "Image to Text",
    "Handwriting to Text"
  ];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("OmniScan"),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            )),
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: events.map((title) {
                return GestureDetector(
                  child: Card(
                    margin: const EdgeInsets.all(20.0),
                    child: getCardByTitle(title),
                  ),
                  onTap: () {
                    /*if (title == "Scan") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanScreen()),
                      );
                    } else*/ if (title == "Merge PDF") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MergeScreen()),
                      );
                    } else if (title == "Compress") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompressScreen()),
                      );
                    } else if (title == "Change Image Background") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeBGScreen()),
                      );
                    } else if (title == "Image to Text") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HTRScreen()),
                      );
                    }/* else if (title == "Handwriting to Text") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HTRScreen()),
                      );
                    }*/
                  },
                );
              }).toList(),
            )));
  }

  Column getCardByTitle(String title) {
    String img = "";
    if (title == "Scan")
      img = "assets/images/scanner.png";
    else if (title == "Merge PDF")
      img = "assets/images/merge.jpg";
    else if (title == "Compress")
      img = "assets/images/compress.jpg";
    else if (title == "Change Image Background")
      img = "assets/images/bg.jpg";
    else if (title == "Image to Text")
      img = "assets/images/ocr.png";
    else if (title == "Handwriting to Text") img = "assets/images/htr.jpg";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: Container(
              child: new Stack(
            children: <Widget>[new Image.asset(img, width: 80.0, height: 80.0)],
          )),
        ),
        Text(title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
      ],
    );
  }
}
