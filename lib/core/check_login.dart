import 'package:fakestore_onescroll/core/routes/routes_path.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/network/status_controller.dart';
import 'constant.dart';

class PresentationController extends BaseController {
  void goToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Persistence.isInitialFirst, false);
    Get.offAllNamed(RoutePaths.home);
  }

  void goToLogin() {
    Get.toNamed(RoutePaths.login);
  }
}
