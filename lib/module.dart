import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_library/data/service/api_service.dart';
import 'package:get/get.dart';
import 'package:dio/adapter.dart';

 SecurityContext? sc;
 locator() async{
  if(sc == null) {
   sc = SecurityContext(withTrustedRoots: false);
   ByteData data = await rootBundle.load("assets/cert.pem"); //This is our own certificate
   sc!.setTrustedCertificatesBytes(data.buffer.asUint8List());

   HttpClient client = new HttpClient(context: sc!);
   client.badCertificateCallback = ((X509Certificate cert, String host, int port) => false); //This will enforced attacker trying with fake certificate
   Dio dio = Dio();
   dio.httpClientAdapter = DefaultHttpClientAdapter()..onHttpClientCreate = (c) => client;
   dio.interceptors.add(LogInterceptor());
   Get.put(dio);
   Get.lazyPut(() => ApiService(Get.find()));
  }

}