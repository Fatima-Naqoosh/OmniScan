
import 'dart:io';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

// ignore: must_be_immutable
class OCRScreen extends StatefulWidget {
  var image;
  OCRScreen(this.image);
  @override
  _OCRScreenState createState() => _OCRScreenState();
  static void processImage(File file) {}
}

class _OCRScreenState extends State<OCRScreen> {
  var text = '';
  Future processImage(image) async {
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {

      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            var text2 = word.text;
            text = text + text2+ ' ';
            print("in loop = ");
            print(text2);
            print(text);
          });
        }
        text = text + '\n';
      }
    }
    print("Text = ");
    print(text);
    textRecognizer.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 100.0),
           Center(
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(blurRadius: 20),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  height: 250,
                  child: Image.file(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                )),
          SizedBox(height: 10.0),
          text == ''
              ? Text('Text will display here')
              :  Expanded(
                              child: SingleChildScrollView(
                                                              child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                  text,
                            ),
                                ),
                              ),
              ),                     
        ],
      ),
    );
  }
}
  


/*

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class OCRScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  OCRScreen(this.cameras);
  @override
  _OCRScreenState createState() {
    return new _OCRScreenState();
  }
}

class _OCRScreenState extends State<OCRScreen> {
  late CameraController controller;
  @override
  void initState() {
    super.initState();
    controller =
        new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return new AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: new CameraPreview(controller),
    );
  }
}*/
