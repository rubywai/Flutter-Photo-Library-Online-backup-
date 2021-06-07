
import 'package:flutter/material.dart';
import 'package:flutter_image_library/controller/HomeController.dart';
import 'package:flutter_image_library/ui/screen/upload_screen.dart';
import 'package:flutter_image_library/ui/widget/item_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ListController _listController = Get.put(ListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listController.getPhotos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Library'),
        actions: [
          Center(
            child: Obx(() {
              if(_listController.deleting.value){
                return Text('Deleting');
              }
              else if(_listController.ref.value){
                return CircularProgressIndicator(color: Colors.white,);
              }
              else return Text('');
            }),
          ),
          IconButton(
              onPressed: () async {
               _listController.getPhotos();
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                var result = await Get.to(UploadScreen());
                if(result != null)
                  _listController.getPhotos();
                  },
              icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Obx((){
          if(_listController.ref.value){
            return CircularProgressIndicator();
          }
          if(!_listController.photoList.isBlank!){
            return ListView.builder(
                itemCount: _listController.photoList.value.length,
                itemBuilder: (context,position){
                  return ListItem(_listController.photoList[position]);
                });
          }
          else if(_listController.error.value){
            return Text('Error');
          }

          return CircularProgressIndicator();
        }),
      ),
    );
  }
}

