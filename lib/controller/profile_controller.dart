import 'package:get/get.dart';
import '../core/app_string.dart';
import '../core/routes/routes_path.dart';
import '../model/network/status_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constant.dart';

class ProfileController extends BaseController {
  var isLoading = false.obs;
  var profile = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final response = await getObject(EndPoint.profile);

      if (response.statusCode == 200 && response.response.isNotEmpty) {
        profile.value = response.response.first as Map<String, dynamic>;
      } else {
        Get.snackbar(AppStrings.errorTitle, AppStrings.noProfileData,);
      }
    } catch (e) {
      Get.snackbar(AppStrings.errorTitle, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    TokenJwk.jwk = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(RoutePaths.login);
  }
}
