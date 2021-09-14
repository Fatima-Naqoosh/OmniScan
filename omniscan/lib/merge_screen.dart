import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
class MergeScreen extends StatefulWidget {
  const MergeScreen({ Key? key }) : super(key: key);

  @override
  _MergeScreenState createState() => _MergeScreenState();
}

class _MergeScreenState extends State<MergeScreen> {
  selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
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
        title: Text("Merge PDF"),
      ),
      body: Center(
        child: Column(
          children: [  
            ElevatedButton(onPressed: selectFiles(), child: Text("Upload PDFs here."))
          ] 
        )
        
      ),
    );
  }

}