import 'package:flutter/material.dart';
import 'package:flutter_image_library/const.dart';
import 'package:flutter_image_library/data/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_library/data/model/read/read_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(title : Text('Photo Library')),
        body: FutureBuilder<List<Photo>>(
          future: ApiService(Dio()).getImages(Const.token),
          builder: (BuildContext context, data){
            if(data.hasData){
              return ListView.builder(
                  itemCount : data.data?.length,
                  itemBuilder: (context,position){
                    return _item(data.data![position]);
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
  Widget _item(Photo photo){
    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Text(photo.type!),
        Text(photo.createdAt!),
        Image.network(photo.thumbUrl!,height: 300,fit: BoxFit.fill,),
        TextButton(onPressed: (){}, child: Text('View Full'))

      ],),
    );
  }
}

