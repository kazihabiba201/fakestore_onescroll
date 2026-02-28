import 'dart:convert';
import 'dart:io';
import 'package:fakestore_onescroll/core/app_string.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/constant.dart';
import '../../model/network/status_controller.dart';

class Network {
  Future<JsonResponse> postJson(String endPoint, {Map<String, dynamic> params = const {}}) async {
    JsonResponse responseJson = JsonResponse();
    try {
      final response = await http.post(
        Uri.parse('${WebService.urlBase}$endPoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(params),
      );

      Map<String, dynamic> jsonData = {};
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonData = Map<String, dynamic>.from(jsonDecode(response.body));
      }

      responseJson = JsonResponse(
        statusCode: response.statusCode,
        response: jsonData,
        message: response.reasonPhrase ?? '',
      );
    } catch (e) {
      debugPrint('${AppStrings.netWorkPostError} $e');
    }
    return responseJson;
  }

  Future<JsonObjectResponse> get(String endPoint, {required Map<String, dynamic> params}) async {
    JsonObjectResponse responseJson = JsonObjectResponse();

    try {
      final response = await http.get(
        Uri.parse('${WebService.urlBase}$endPoint'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${TokenJwk.jwk}',
        },
      );

      dynamic jsonData;

      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body);
        if (jsonData is Map<String, dynamic>) {
          jsonData = [jsonData];
        }
      } else {
        jsonData = [];
      }

      responseJson = JsonObjectResponse(
        statusCode: response.statusCode,
        response: List<dynamic>.from(jsonData),
        message: response.reasonPhrase ?? '',
      );
    } catch (e) {
      debugPrint('${AppStrings.netWorkGetError} $e');
    }

    return responseJson;
  }
}