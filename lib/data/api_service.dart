
import 'dart:io';
import 'package:flutter_image_library/const.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'model/read/read_model.dart';

part 'api_service.g.dart';
@RestApi()
abstract class ApiService{
  factory ApiService(Dio dio,{String? baseUrl}) => _ApiService(dio);
  @GET('${Const.baseUrl}/images')
  Future<List<Photo>> getImages(@Query('access_token') String query);

  @POST(Const.uploadUrl)
   Future<void> uploadImage(@Part(name: 'imagedata')File file,@Query('access_token') String token,
  {@SendProgress() ProgressCallback? callBack}
  );

  @DELETE('${Const.baseUrl}/images:{id}')
  Future<void> deleteImage(@Path('id') String id);

}