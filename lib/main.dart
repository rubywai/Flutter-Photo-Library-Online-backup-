
import 'package:flutter/material.dart';
import 'package:flutter_image_library/ui/screen/list_screen.dart';
import 'package:get/get.dart';

 void main()  async{
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     home: HomeScreen(),
    );
  }


}
