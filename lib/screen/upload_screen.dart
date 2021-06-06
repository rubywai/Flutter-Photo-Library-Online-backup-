import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_library/const.dart';
import 'package:flutter_image_library/data/api_service.dart';
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
  var log = LogInterceptor(
      requestBody: true, logPrint: (log) => print(log), responseBody: true);
  ApiService _apiService = ApiService(
      Dio()
        ..interceptors.add(LogInterceptor(
            requestBody: true,
            logPrint: (log) => print(log),
            responseBody: true)),
      baseUrl: Const.uploadUrl);
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
                print('Upoad');
                _apiService.uploadImage(_image!, Const.token,
                    callBack: (send, total) {
                  double  percentage =  (send/total);
                  print('upload percentage is $percentage');
                  _controller.sink.add(percentage);
                }).then((value){
                  setState(() {
                    _visiblecomplete = true;
                    _visibleImage = false;
                  });
                });
              },
            ),
          ),
          Visibility(
              visible: _visibleImage,
              child: StreamBuilder<double>(
                stream: _controller.stream,
                builder: (context, data) {
                  if (data.hasData) {
                    return Column(children: [
                      LinearProgressIndicator(value: data.data,),
                      Text('Uploading ${(data.data! *100).toInt()} %')
                    ],);
                  }
                  return Center();
                },
              )),
              Visibility(
                visible: _visiblecomplete,
                child: ElevatedButton(child: Text('Complete'),onPressed: (){
                    Navigator.pop(context,'complete');
                },))

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
