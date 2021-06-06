import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_library/const.dart';
import 'package:flutter_image_library/data/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_library/data/model/read/read_model.dart';
import 'package:flutter_image_library/screen/upload_screen.dart';

void main() {
  runApp(MaterialApp(
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
    
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          //backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text('Photo Library'),
            actions: [
              IconButton(
                  onPressed: () async {
                    var result = await Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => UploadScreen()));
                    if (result != null) {
                      setState(() {});
                    }
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          body: FutureBuilder<List<Photo>>(
            
            future: api_service.getImages(Const.token),
            builder: (BuildContext context, data) {
              print(data.connectionState);
              if (data.hasData) {
                return ListView.builder(
                    itemCount: data.data?.length,
                    itemBuilder: (context, position) {
                      return _item(data.data![position], api_service);
                    });
              
              } 
              else if(data.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else if (data.hasError) {
                return Text(data.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _item(Photo photo,ApiService apiService) {
    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(onPressed: (){
              apiService.deleteImage(photo.imageId!).then((value) => print('Successful')
              );
            }, icon: Icon(Icons.delete)),
          ),
          Text(photo.type!),
          Text(photo.createdAt!),
          CachedNetworkImage(
            height: 300,
            fit: BoxFit.contain,
            imageUrl: photo.url!,
            errorWidget: (ctx, str, err) => Icon(
              Icons.error,
              size: 200,
            ),
            placeholder: (ctx, str) => SizedBox(
              child: Center(child: CircularProgressIndicator()),
              height: 300,
            ),
          ),
          TextButton(onPressed: () {}, child: Text('View Full'))
        ],
      ),
    );
  }
}
