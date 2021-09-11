

import 'package:flutter_image_library/data/service/api_service.dart';
import 'package:flutter_image_library/data/model/read/read_model.dart';
import 'package:get/get.dart';

import '../const.dart';
import '../module.dart';
class ListController extends GetxController{


  var error = false.obs;
  var ref = false.obs;
  var deleting = false.obs;
  RxList<Photo> photoList = List<Photo>.empty(growable: true).obs;
  @override
  void onInit() {
    super.onInit();
  }
  void getPhotos() async{
    await locator();
    ApiService _apiService  = Get.find();
    ref.value = true;
    _apiService.getImages(Const.token)
        .then((List<Photo> photos){
          error.value = false;
          ref.value = false;
          photoList.value = photos;
    })
        .catchError((e){
          print("This is Error");
          error.value = true;
          ref.value = false;
    });
  }
  void deletePhoto(String imageId){
    ApiService _apiService  = Get.find();
    deleting.value = true;
    _apiService.deleteImage(imageId, Const.token)
        .then((value){
          ref.value = true;
          getPhotos();
        })
        .catchError((e) { ref.value = false; } )
        .whenComplete(()  {
          deleting.value = false;
        });
    ;
  }
}