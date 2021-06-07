import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_library/const.dart';
import 'package:flutter_image_library/controller/UploadController.dart';
import 'package:flutter_image_library/data/api_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  bool _visibleImage = false;
  bool _visiblecomplete = false;
  StreamController<double> _controller = StreamController();
  UploadController _uploadController = Get.put(UploadController());
  @override
  Widget build(BuildContext context) {
    print('app');
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Screen'),
      ),
      body: Center(
        child: Column(children: [
          IconButton(
              onPressed: () async {
                await getImage();
              },
              icon: Icon(Icons.image,color: Colors.blue,)),
          Visibility(
            visible: _visibleImage,
            child: _image == null ? Center() : Image.file(_image!),
          ),
          Visibility(
            visible: _visibleImage,
            child: ElevatedButton(
              child: Text('Upload'),
              onPressed: () {
                _uploadController.upload(_image!);
              },
            ),
          ),
          Obx((){
            if(_uploadController.uploading.value)
            return Column(children: [
              LinearProgressIndicator(value: _uploadController.percentage.value,),
              Text('Uploading ${(_uploadController.percentage *100).toInt()} %')
            ],);
            return Center();
          }),
          Obx((){
            if(_uploadController.complete.value)
            return ElevatedButton(
                child: Text('Complete'),
                onPressed: () {
                  Get.back(result: 'complete',);
                }
            );
            return Center();
            }
            ),

        ]),
      ),
    );
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        print('select');
        _image = File(pickedFile.path);
        _visibleImage = true;
        _visiblecomplete = false;
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.close();
  }
}
