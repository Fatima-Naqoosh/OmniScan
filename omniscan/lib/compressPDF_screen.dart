import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:pdf_compressor/pdf_compressor.dart';

class compressPDFScreen extends StatefulWidget {
  const compressPDFScreen({ Key? key }) : super(key: key);
  @override
  _compressPDFScreenState createState() => _compressPDFScreenState();
}

class _compressPDFScreenState extends State<compressPDFScreen> {
  
  late File _PDF;
  bool _loaded = false;
  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    setState( () {
      _loaded = true;
      _PDF = result as File;
    });
  }
 
  void compressPDF(File file) async {
    // ignore: unused_local_variable
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    //var result = await PdfCompressor.compressPdfFile(filePath, outPath, CompressQuality.MEDIUM);
    print(file.lengthSync());
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
              ? Center()
              : Center(
            child: FlatButton.icon(
              icon: Icon(
                Icons.file_copy,
                size: 100,
              ),
              label: Text(''),
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                pickFile();
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
                  compressPDF(_PDF);
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