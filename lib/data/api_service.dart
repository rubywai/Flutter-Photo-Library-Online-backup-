
import 'package:flutter_image_library/const.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'model/read/read_model.dart';
part 'api_service.g.dart';
@RestApi(baseUrl: Const.baseUrl)
abstract class ApiService{
  factory ApiService(Dio dio) => _ApiService(dio);
  @GET('/images')
  Future<List<Photo>> getImages(@Query('access_token') String query);

}