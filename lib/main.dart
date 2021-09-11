
import 'package:flutter/material.dart';
import 'package:flutter_image_library/ui/screen/list_screen.dart';
import 'package:get/get.dart';

 void main()  async{
  runApp(
      MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

