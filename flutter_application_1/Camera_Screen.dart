import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class CameraScreen extends StatefulWidget {
  @override 
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraCOntroller? controller;
  List<CameraDescription? cameras;
  Future<void>?
 _initializeControllerFuture;

 @override
 void initState() {
  super.initState();
  _initializeCamera();
 }

Future<void> _initializeCamera()
async{
  cameras = await availableCameras();
  if(cameras != null && cameras!.isNotEmpty) {
    controller =
  CameraController(cameras![0],ResolutionPresent.high);
    _initializeControllerFuture = controller!.initialize();
       if(mounted){
        setState(() {});
    }  
  }
}

 @override
 Widget build(BuildContext context) {
  if(controller == null || ! controller!.value.isInitialized){
    return Center(child:CircularProgressIndicator());
  }
    return Scaffold(
      appBar: AppBar(title: Text("Capture Coffee Beans")),
      body: CameraPreview(controller!),floatingtActionButton:
      FloatingActionButton(
        child: Icon(Icons.camera_alt),onPressed: () async{
          try{
            await
        _iniatilizeControllerFuture;
             final image = await
        controller!.takePicture();
        //Navigate to the next page with the image        
          } catch(e) {
            print(e);
        }
      },
    ),
  );
}
  @override
  void dispose() {
    controller?.dispose();
    super.dispose
  } 