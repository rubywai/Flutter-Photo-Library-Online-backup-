import 'package:dio/dio.dart';
import 'package:flutter_image_library/data/api_service.dart';
import 'package:get/get.dart';

void locator(){
  Get.put(Dio()..
  interceptors.add(LogInterceptor()));
  Get.put(ApiService(Get.find()));

}