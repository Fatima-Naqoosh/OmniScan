import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'compressed_image_view.dart';
class CompressScreen extends StatefulWidget {
  const CompressScreen({ Key? key }) : super(key: key);

  @override
  _CompressScreenState createState() => _CompressScreenState();
}

class _CompressScreenState extends State<CompressScreen> {
  
  late File _image;
  int image_quality = 50;
  bool _loaded = false;
  getImageFile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState( () {
      _loaded = true;
      _image = File(image!.path);
    }
    );
  }
 
  void compressImage(File file) async {
    // ignore: unused_local_variable
    final filePath = file.absolute.path;
  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  print(filePath);
  print(outPath);
    var result = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        quality: image_quality,
      );
    print(file.lengthSync());
    print(result!.lengthSync());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => compressedImagePage(
                  path: result.path,
                )));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compress Image"),
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
            SizedBox(height: 100.0),
          _loaded
              ? Center(
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
                    _image,
                    fit: BoxFit.cover,
                  ),
                ))
              : Center(
            child: FlatButton.icon(
              icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
              label: Text(''),
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                getImageFile();
              },
            ),
          ),
          SizedBox(height: 10.0),
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
                  "Compress",
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