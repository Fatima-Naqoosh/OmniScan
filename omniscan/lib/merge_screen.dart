import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
export 'package:pdf_merger/pdf_merger_response.dart';
export 'home_screen.dart';
import 'File_List.dart';

class MergeScreen extends StatefulWidget {
  const MergeScreen({Key? key}) : super(key: key);

  @override
  _MergeScreenState createState() => _MergeScreenState();
}

class _MergeScreenState extends State<MergeScreen> {
  FilePickerResult? result;
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    var fileType;
    var fileTypeList;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selected File Type:  ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                DropdownButton(
                  value: fileType,
                  items: fileTypeList.map((String type) {
                    return DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: TextStyle(fontSize: 20),
                        ));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      fileType = value!;
                      file = null;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                String? fileType;
                pickFiles(fileType);
              },
              child: Text('Pick file'),
            ),
            if (file != null) fileDetails(file!),
            if (file != null)
              ElevatedButton(
                onPressed: () {
                  viewFile(file!);
                },
                child: Text('View Selected File'),
              )
          ],
        ),
      ),
    );
  }

  Widget fileDetails(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${file.name}'),
          Text('File Size: $size'),
          Text('File Extension: ${file.extension}'),
          Text('File Path: ${file.path}'),
        ],
      ),
    );
  }

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        loadSelectedFiles(result!.files);
        break;
    }
  }

  // multiple file selected
  // navigate user to 2nd screen to show selected files
  void loadSelectedFiles(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FileList(files: files, onOpenedFile: viewFile)));
  }

  // open the picked file
  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}

 /* selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {});

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
          child: Column(children: [
        ElevatedButton(
            onPressed: selectFiles(), child: Text("Upload PDFs here."))
      ])),
    );
  }
} */
/*
class PdfMerger {
  static const MethodChannel _channel = const MethodChannel('pdf_merger');
  static final mergeMultiplePDFResponse = MergeMultiplePDFResponse().obs;
  static final createPDFFromMultipleImageResponse =
      CreatePDFFromMultipleImageResponse().obs;
  static final createImageFromPDFResponse = CreateImageFromPDFResponse().obs;
  static final sizeFormFilePathResponse = SizeFormPathResponse().obs;

  /// For Merger multiple PDF
  /// paths is a list of paths, example List<String> allSelectedFilePath.
  ///  outputDirPath is output path with filename, example /user/android/download/ABC.pdf
  static Future<MergeMultiplePDFResponse> mergeMultiplePDF(
      {required List<String> paths, required String outputDirPath}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'paths': paths,
      'outputDirPath': outputDirPath
    };

    if (paths.length == 0) {
      mergeMultiplePDFResponse.value.status = Status.error;
      mergeMultiplePDFResponse.value.message = Status.errorMessage;
    } else {
      try {
        bool isPDF = true;

        for (int i = 0; i < paths.length; i++) {
          if (!GetUtils.isPDF(paths[i])) {
            isPDF = false;
          }
        }

        if (!isPDF) {
          mergeMultiplePDFResponse.value.status = Status.error;
          mergeMultiplePDFResponse.value.message = Status.errorMessagePDF;
        } else {
          final String? response =
              await _channel.invokeMethod('mergeMultiplePDF', params);

          if (response != "error") {
            mergeMultiplePDFResponse.value.status = Status.success;
            mergeMultiplePDFResponse.value.message = Status.successMessage;
            mergeMultiplePDFResponse.value.response = response;
          } else {
            mergeMultiplePDFResponse.value.status = Status.error;
            mergeMultiplePDFResponse.value.message = Status.errorMessage;
          }
        }
      } on Exception catch (exception) {
        mergeMultiplePDFResponse.value.status = Status.error;
        mergeMultiplePDFResponse.value.message = exception.toString();
      } catch (e) {
        mergeMultiplePDFResponse.value.status = Status.error;
        mergeMultiplePDFResponse.value.message = e.toString();
      }
    }

    return mergeMultiplePDFResponse.value;
  }

  /// For Creating a PDF from multiple image
  /// paths is a list of paths, example List<String> allSelectedFilePath.
  /// outputDirPath is output path with filename, example /user/android/download/ABC.pdf
  /// Optional params maxWidth : default set to 360, maxHeight : default set to 360, needImageCompressor : default set to true.
  static Future<CreatePDFFromMultipleImageResponse> createPDFFromMultipleImage(
      {required List<String> paths,
      required String outputDirPath,
      int? maxWidth,
      int? maxHeight,
      bool? needImageCompressor}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'paths': paths,
      'outputDirPath': outputDirPath,
      'needImageCompressor': needImageCompressor ?? true,
      'maxWidth': maxWidth ?? 360,
      'maxHeight': maxHeight ?? 360
    };

    if (paths.length == 0) {
      createPDFFromMultipleImageResponse.value.status = Status.error;
      createPDFFromMultipleImageResponse.value.message = Status.errorMessage;
    } else {
      try {
        bool isImage = true;

        for (int i = 0; i < paths.length; i++) {
          if (!GetUtils.isImage(paths[i])) {
            isImage = false;
          }
        }

        if (!isImage) {
          createPDFFromMultipleImageResponse.value.status = Status.error;
          createPDFFromMultipleImageResponse.value.message =
              Status.errorMessageImage;
        } else {
          final String? response =
              await _channel.invokeMethod('createPDFFromMultipleImage', params);

          if (response != "error") {
            createPDFFromMultipleImageResponse.value.status = Status.success;
            createPDFFromMultipleImageResponse.value.message =
                Status.successMessage;
            createPDFFromMultipleImageResponse.value.response = response;
          } else {
            createPDFFromMultipleImageResponse.value.status = Status.error;
            createPDFFromMultipleImageResponse.value.message =
                Status.errorMessage;
          }
        }
      } on Exception catch (exception) {
        createPDFFromMultipleImageResponse.value.status = Status.error;
        createPDFFromMultipleImageResponse.value.message = exception.toString();
      } catch (e) {
        createPDFFromMultipleImageResponse.value.status = Status.error;
        createPDFFromMultipleImageResponse.value.message = e.toString();
      }
    }

    return createPDFFromMultipleImageResponse.value;
  }

  /// For Creating a Image from PDF
  /// paths selected file path (String). Example user/android.downlaod/MYPDF.pdf
  /// outputDirPath is output path with filename, example /user/android/download/ABC.pdf
  /// Optional params maxWidth : default set to 360, maxHeight : default set to 360, createOneImage : default set to true.
  static Future<CreateImageFromPDFResponse> createImageFromPDF(
      {required String path,
      required String outputDirPath,
      int? maxWidth,
      int? maxHeight,
      createOneImage}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'path': path,
      'outputDirPath': outputDirPath,
      'maxWidth': maxWidth ?? 360,
      'maxHeight': maxHeight ?? 360,
      'createOneImage': createOneImage ?? true
    };

    if (path == "") {
      createImageFromPDFResponse.value.status = Status.error;
      createImageFromPDFResponse.value.message = Status.errorMessage;
    } else {
      try {
        bool isImage = GetUtils.isPDF(path);

        if (!isImage) {
          createImageFromPDFResponse.value.status = Status.error;
          createImageFromPDFResponse.value.message = Status.errorMessageImage;
        } else {
          final response =
              await _channel.invokeMethod('createImageFromPDF', params);

          if (response != null && response.length != 0) {
            createImageFromPDFResponse.value.response = [];
            for (int i = 0; i < response.length; i++) {
              createImageFromPDFResponse.value.response!.add(response[i]);
            }

            createImageFromPDFResponse.value.status = Status.success;
            createImageFromPDFResponse.value.message = Status.successMessage;
          } else {
            createImageFromPDFResponse.value.status = Status.error;
            createImageFromPDFResponse.value.message = Status.errorMessage;
          }
        }
      } on Exception catch (exception) {
        createImageFromPDFResponse.value.status = Status.error;
        createImageFromPDFResponse.value.message = exception.toString();
      } catch (e) {
        createImageFromPDFResponse.value.status = Status.error;
        createImageFromPDFResponse.value.message = e.toString();
      }
    }

    return createImageFromPDFResponse.value;
  }

  /// Check File Size of any File
  /// paths selected file path (String). Example user/android.downlaod/MYPDF.pdf
  static Future<SizeFormPathResponse> sizeFormPath(
      {required String path}) async {
    final Map<String, dynamic> params = <String, dynamic>{'path': path};

    if (path == "") {
      sizeFormFilePathResponse.value.status = Status.error;
      sizeFormFilePathResponse.value.message = Status.errorMessage;
    } else {
      try {
        final String? response =
            await _channel.invokeMethod('sizeForLocalFilePath', params);

        if (response != "error") {
          sizeFormFilePathResponse.value.status = Status.success;
          sizeFormFilePathResponse.value.message = Status.successMessage;
          sizeFormFilePathResponse.value.response = response;
        } else {
          sizeFormFilePathResponse.value.status = Status.error;
          sizeFormFilePathResponse.value.message = Status.errorMessage;
        }
      } on Exception catch (exception) {
        sizeFormFilePathResponse.value.status = Status.error;
        sizeFormFilePathResponse.value.message = exception.toString();
      } catch (e) {
        sizeFormFilePathResponse.value.status = Status.error;
        sizeFormFilePathResponse.value.message = e.toString();
      }
    }

    return sizeFormFilePathResponse.value;
  }

  /// For Information about build, example buildDate, app versionName, app versionCode, packageName, packageName.
  static Future<BuildInfoResponse> buildInfo() async {
    String buildDate = await _channel.invokeMethod('buildDate');
    String buildDateWithTime = await _channel.invokeMethod('buildDateWithTime');
    String versionName = await _channel.invokeMethod('versionName');
    String versionCode = await _channel.invokeMethod('versionCode');
    String packageName = await _channel.invokeMethod('packageName');
    String appName = await _channel.invokeMethod('packageName');

    return BuildInfoResponse(
        buildDate: buildDate == "null" || buildDate == "error" ? "" : buildDate,
        buildDateWithTime:
            buildDateWithTime == "null" || buildDateWithTime == "error"
                ? ""
                : buildDateWithTime,
        versionNumber:
            versionName == "null" || versionName == "error" ? "" : versionName,
        buildNumber:
            versionCode == "null" || versionCode == "error" ? "" : versionCode,
        packageName:
            packageName == "null" || packageName == "error" ? "" : packageName,
        appName: appName == "null" || appName == "error" ? "" : appName);
  }
}
*/