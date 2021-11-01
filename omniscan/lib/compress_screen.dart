import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
class CompressScreen extends StatefulWidget {
  const CompressScreen({ Key? key }) : super(key: key);

  @override
  _CompressScreenState createState() => _CompressScreenState();
}

class _CompressScreenState extends State<CompressScreen> {
  
  late File _image;
  late int image_quality;
  late int file_quality;
  getImageFile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState( () {
      _image = image as File;
    }
    );
  }
  getPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
    );
  }
  void compressImage(File file) async {
    // ignore: unused_local_variable
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, file.absolute.path,
        quality: image_quality,
      );
    print(file.lengthSync());
    print(result!.lengthSync());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compress Files"),
      ),
      body: Container(decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),  fit: BoxFit.cover,
        ) 
      ),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration:  InputDecoration(
              labelText: 'For Image Compression'
            ),
            ),

            SizedBox(
              width: 300,
              height: 50,
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  getImageFile();
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Upload Image",
                  style: TextStyle(color: Colors.white),
                ),
                ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration:  InputDecoration(
              enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
              labelText: 'Enter percentage compression'
            ),
            ),

            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 300,
              height: 50,
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  compressImage(_image);
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Apply",
                  style: TextStyle(color: Colors.white),
                ),
                ),
            ),

            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration:  InputDecoration(
              labelText: 'For PDF Compression'
            ),
            ),

            SizedBox(
              width: 300,
              height: 50,
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  getPDFFile();
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Upload PDF",
                  style: TextStyle(color: Colors.white),
                ),
                ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration:  InputDecoration(
              enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
              labelText: 'Enter percentage compression'
            ),
            ),

            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 300,
              height: 50,
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  //compressFile(_pdf);
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Apply",
                  style: TextStyle(color: Colors.white),
                ),
                ),
            ),

        
      ],
        )
      ),
    );
  }

}