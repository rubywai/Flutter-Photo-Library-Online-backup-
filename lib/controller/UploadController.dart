import 'dart:io';

import 'package:flutter_image_library/const.dart';
import 'package:flutter_image_library/data/service/api_service.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  ApiService _apiService = Get.find();
  var percentage = 0.0.obs;
  var error = false.obs;
  var uploading = false.obs;
  var complete = false.obs;

  void upload(File file) {
    uploading.value = true;
    _apiService
        .uploadImage(file, Const.token, callBack: (send, total) {
          double per = (send / total);
          percentage.value = per;
        })
        .then((value) {
          print('Completing');
          complete.value = true;
        })
        .catchError((e) => error.value = true)
        .whenComplete(() => uploading.value = false);
  }
}
