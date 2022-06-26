import 'package:dio/dio.dart' hide Headers;
import 'package:moddhobitto_mobile/constant/constant.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: Constant.BASE_URL)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
}
