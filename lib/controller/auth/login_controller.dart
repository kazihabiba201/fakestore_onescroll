import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_string.dart';
import '../../core/constant.dart';
import '../../core/error.dart';
import '../../core/routes/routes_path.dart';
import '../../model/network/status_controller.dart';

class LoginController extends BaseController {
  final _formKey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerPass = TextEditingController();
  bool _isCompleteForm = false, _isVisibilityPass = false, _isLoading = false;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get controllerName => _controllerName;
  TextEditingController get controllerPass => _controllerPass;
  bool get isCompleteForm => _isCompleteForm;
  bool get isVisibilityPass => _isVisibilityPass;
  bool get isLoading => _isLoading;

  void changePasswordVisibility() {
    _isVisibilityPass = !_isVisibilityPass;
    update([AppStrings.labelPassword]);
  }

  void onChangeUserName(String? _) => _validateBtn();
  void onChangePass(String? _) => _validateBtn();

  void _validateBtn() {
    _isCompleteForm = _controllerName.text.trim().isNotEmpty && _controllerPass.text.trim().isNotEmpty;
    update([AppStrings.btnLoginId]);
  }

  String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.hintUserName;
    return null;
  }

  String? validatePass(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.hintPassWord;
    return null;
  }

  final Map<String, String> _testUsers = {'mor_2314': '83r5^_', 'johnd': 'm38rmF', 'kminchelle': '0lelplR'};

  void onLogin() async {
    _isLoading = true;
    update();

    FocusScope.of(Get.context!).unfocus();

    final username = _controllerName.text.trim();
    final password = _controllerPass.text.trim();

    if (_testUsers.containsKey(username) && _testUsers[username] == password) {
      TokenJwk.jwk = "${AppStrings.fakeStoreToken}${username}_${DateTime.now().millisecondsSinceEpoch}";

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool(Persistence.isLogged, true);
      await prefs.setString(Persistence.user, username);
      await prefs.setString(Persistence.pass, password);
      await prefs.setString(Persistence.token, TokenJwk.jwk);

      Get.offAllNamed(RoutePaths.home);
    } else {
      Errors().errors(401, message: AppStrings.errorInvalidCredentials);
    }

    _isLoading = false;
    update();
  }


}
