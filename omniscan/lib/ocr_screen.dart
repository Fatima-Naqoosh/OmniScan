/*import 'package:flutter/material.dart';
class OCRScreen extends StatefulWidget {
  const OCRScreen({ Key? key }) : super(key: key);

  @override
  _OCRScreenState createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen>  {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMAGE TO TEXT"),
      ),
      body: Center(
      
      ),
     
    );
  }

} */
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
}
