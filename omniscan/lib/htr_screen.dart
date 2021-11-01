import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omniscan/ocr_screen.dart';
import 'camera_screen.dart';

class HTRScreen extends StatefulWidget {
  const HTRScreen({Key? key}) : super(key: key);
  @override
  _HTRScreenState createState() {return new _HTRScreenState();}
}

class _HTRScreenState extends State<HTRScreen> {

  getImageFile() async {
    final ImagePicker _picker = ImagePicker();
    final File? image = (await _picker.pickImage(source: ImageSource.gallery)) as File?;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OCRScreen(image)),
    );
  }
  Future openCamera() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image to Text"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 50,
              // ignore: deprecated_member_use
              child: IconButton(
                icon: Icon(
                Icons.photo_album,
                size: 100,
              ),
                onPressed: () {
                  getImageFile();
                },
                color: Colors.blue,
                ),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 300,
              height: 50,
              // ignore: deprecated_member_use
              child: IconButton(
                icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
                onPressed: () {
                  openCamera();
                },
                color: Colors.blue,
                
                ),
            ), 
      ],
        )
      ),
    );
  }
}
