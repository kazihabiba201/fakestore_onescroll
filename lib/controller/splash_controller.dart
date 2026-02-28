import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constant.dart';
import '../core/routes/routes_path.dart';
import '../model/network/status_controller.dart';

class SplashController extends BaseController {
  @override
  void onReady() {
    super.onReady();
    _validateLogin();
  }

  Future<void> _validateLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();

    final logged = prefs.getBool(Persistence.isLogged) ?? false;
    TokenJwk.jwk = prefs.getString(Persistence.token) ?? '';

    String targetRoute;

    if (logged && TokenJwk.jwk.isNotEmpty) {
      targetRoute = RoutePaths.home;
    } else {
      targetRoute = RoutePaths.login;
    }

    Get.offAllNamed(targetRoute);
  }
}
