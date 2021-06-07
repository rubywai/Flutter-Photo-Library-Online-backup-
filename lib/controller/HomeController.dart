

import 'package:flutter_image_library/data/api_service.dart';
import 'package:flutter_image_library/data/model/read/read_model.dart';
import 'package:get/get.dart';

import '../const.dart';

class ListController extends GetxController{
  ApiService _apiService = Get.find();
  var error = false.obs;
  var ref = false.obs;
  var deleting = false.obs;
  RxList<Photo> photoList = List<Photo>.empty(growable: true).obs;
  @override
  void onInit() {
    super.onInit();
  }
  void getPhotos() {
    ref.value = true;
    _apiService.getImages(Const.token)
        .then((List<Photo> photos){
          error.value = false;
          photoList.value = photos;
    })
        .catchError((error){
          error.value = true;
    }).whenComplete(() => ref.value = false);
  }
  void deletePhoto(String imageId){
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