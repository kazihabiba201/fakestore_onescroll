import 'package:get/get.dart';
import '../product.dart';
import '../token/token.dart';
import 'network.dart';


abstract class BaseController extends GetxController {
  Future<JsonResponseToken> postToken(String endPoint, {Map<String, dynamic> params = const {}}) async {
    JsonResponseToken responseObj = JsonResponseToken();
    final network = Network();
    final JsonResponse response = await network.postJson(endPoint, params: params);

    if (response.statusCode == 200) {
      Token token = Token.fromJson(response.response);
      responseObj.statusCode = response.statusCode;
      responseObj.message = response.message;
      responseObj.response = token;
    } else {
      responseObj.statusCode = response.statusCode;
      responseObj.message = response.message;
    }
    return responseObj;
  }


  Future<JsonObjectResponse> getObject(String endPoint,
      {Map<String, dynamic> params = const {}}) async {

    final network = Network();
    return await network.get(endPoint, params: params);
  }

}

class JsonResponse {
  String message;
  int statusCode;
  Map<String,dynamic> response;

  JsonResponse({
    this.message = '',
    this.statusCode = 0,
    this.response = const {},
  });
}

class JsonResponseToken {
  String message;
  int statusCode;
  Token? response;

  JsonResponseToken({
    this.message = '',
    this.statusCode = 0,
    this.response,
  });
}


class JsonObjectResponse {
  String message;
  int statusCode;
  List<dynamic> response;

  JsonObjectResponse({
    this.message = '',
    this.statusCode = 0,
    this.response = const [],
  });
}

class JsonResponseList {
  String message;
  int statusCode;
  List<Product> response;

  JsonResponseList({
    this.message = '',
    this.statusCode = 0,
    this.response = const [],
  });
}