import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_library/const.dart';
import 'package:flutter_image_library/data/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_library/data/model/read/read_model.dart';
import 'package:flutter_image_library/module.dart';
import 'package:flutter_image_library/ui/screen/list_screen.dart';
import 'package:get/get.dart';

void main()  {
  locator();
  runApp(
      MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: non_constant_identifier_names
  var api_service =ApiService(Dio()..interceptors.add(LogInterceptor()));
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
     home: HomeScreen(),
    );
  }


}
