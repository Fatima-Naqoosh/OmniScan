import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
class ChangeBGScreen extends StatefulWidget {
  const ChangeBGScreen({ Key? key }) : super(key: key);

  @override
  _ChangeBGScreenState createState() => _ChangeBGScreenState();
}

class _ChangeBGScreenState extends State<ChangeBGScreen> {
  selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if(result != null) {
   PlatformFile file = result.files.first;
   
   print(file.name);
   print(file.bytes);
   print(file.size);
   print(file.extension);
   print(file.path);
  } else {
   // User canceled the picker
   print("no file uploaded");
  }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Image Background"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 50,
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  selectFiles();
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
            SizedBox(
              width: 300,
              height: 50,
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  selectFiles();
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Upload Background Image",
                  style: TextStyle(color: Colors.white),
                ),
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
                  print("change background");
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