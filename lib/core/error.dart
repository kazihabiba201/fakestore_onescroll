import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_string.dart';
class Errors {
  void errors(int code, {String message = ''}) {
    switch (code) {
      case 401:
        Get.snackbar(
          AppStrings.oopsTitle,
          message.isEmpty ? AppStrings.unauthorized : message,
          colorText: Colors.white,
          backgroundColor: Colors.cyan,
        );
        break;
      case 404:
        Get.snackbar(
          AppStrings.oopsTitle,
          message.isEmpty ? AppStrings.notFound : message,
          colorText: Colors.white,
          backgroundColor: Colors.cyan,
        );
        break;
      case 0:
        Get.snackbar(
          AppStrings.oopsTitle,
          message.isEmpty ? AppStrings.somethingWentWrong : message,
          colorText: Colors.white,
          backgroundColor: Colors.cyan,
        );
        break;
    }
  }
}