import 'package:flutter/material.dart';
import 'package:omniscan/scan_screen.dart';
import 'package:omniscan/merge_screen.dart';
import 'package:omniscan/compress_screen.dart';
import 'package:omniscan/changebg_screen.dart';
import 'package:omniscan/ocr_screen.dart';
import 'package:omniscan/htr_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> events = [ "Scan", "Merge PDF", "Compress", "Change Image Background", "Image to Text", "Handwriting to Text"];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OmniScan"),
      ),
      body: Container(decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),  fit: BoxFit.cover,
        ) 
      ),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: events.map((title) {
            return GestureDetector(
              child: Card(
                margin: const EdgeInsets.all(20.0),
                child: getCardByTitle(title),
              ),
              onTap: () {
                  if (title == "Scan") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      	builder: (context) => ScanScreeen()
                      ),
                    );  
                  }  
                  
                  else if (title == "Merge PDF") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      	builder: (context) => MergeScreeen()
                      ),
                    );
                  }
                  else if (title == "Compress") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      	builder: (context) => CompressScreeen()
                      ),
                    );
                  }
                  else if (title == "Change Image Background") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      	builder: (context) => ChangeBGScreeen()
                      ),
                    );
                  }
                  else if (title == "Image to Text") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      	builder: (context) => OCRScreeen()
                      ),
                    );
                  }
                  else if (title == "Handwriting to Text") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      	builder: (context) => HTRScreeen()
                      ),
                    );
                  }   
              }, ); 
          }).toList(),
        )
      ) 
    );
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
  else if (title == "Handwriting to Text")
    img = "assets/images/htr.jpg";
  
  return Column (
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Center(
        child: Container(
          child: new Stack(
            children: <Widget>[
              new Image.asset(img, width: 80.0, height: 80.0)
            ],

          )),
      ), Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold ))
    ],
  );

}


}

