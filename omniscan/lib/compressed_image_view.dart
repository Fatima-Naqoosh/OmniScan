import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:gallery_saver/gallery_saver.dart';

class compressedImagePage extends StatelessWidget {
  const compressedImagePage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(
                Icons.download,
                size: 27,
              ),
              onPressed: () {
                /*(File(path)) {
                  GallerySaver.saveImage(path);
              };*/
              }), 
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
