import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_library/controller/HomeController.dart';
import 'package:flutter_image_library/data/api_service.dart';
import 'package:flutter_image_library/data/model/read/read_model.dart';
import 'package:get/get.dart';

import '../../const.dart';

class ListItem extends StatelessWidget {
  final Photo _photo;
  ListController _listController = Get.find();
  ListItem(this._photo);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(onPressed: (){
              _listController.deletePhoto(_photo.imageId!);
            }, icon: Icon(Icons.delete)),
          ),
          Text('Image Type - ${_photo.type!}'),
          Text('Date created - ${_photo.createdAt!}'),
          CachedNetworkImage(
            height: 200,
            fit: BoxFit.fitWidth,
            imageUrl: _photo.url!,
            errorWidget: (ctx, str, err) => Icon(
              Icons.error,
              size: 200,
            ),
            placeholder: (ctx, str) => SizedBox(
              child: Center(child: CircularProgressIndicator()),
              height: 300,
            ),
          ),
          TextButton(onPressed: () {
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: CachedNetworkImage(imageUrl: _photo.url!,
                    fit: BoxFit.fill,),
                  contentPadding: EdgeInsets.all(0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),

                );
              },
            );
          }, child: Text('View Full'))
        ],
      ),
    );
  }
}

