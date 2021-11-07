import 'package:camera/camera.dart';
import 'camera_view.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future setupCameras() async {
    cameras = await availableCameras();
    _cameraController =
        new CameraController(cameras[0], ResolutionPreset.ultraHigh);
    await _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                  /*width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,*/
                  aspectRatio: _cameraController.value.aspectRatio,
                  child: CameraPreview(_cameraController));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ignore: deprecated_member_use
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        onPressed: () {
                          takePhoto(context);
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(
                  path: file.path,
                )));
  }
}
