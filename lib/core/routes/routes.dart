import 'package:fakestore_onescroll/core/routes/routes_path.dart';
import 'package:fakestore_onescroll/view/profile_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../view/home_screen.dart';
import '../../view/login_screen.dart';
import '../../view/splash_screen.dart';
import '../binding.dart';

final routes = [
  GetPage(
    name: '/',
    page: () => const SplashPage(),
    transition: Transition.circularReveal,
  ),

  GetPage(
    name: RoutePaths.login,
    page: () => const LoginPage(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: RoutePaths.home,
    page: () =>  const HomeScreen(),
    transition: Transition.rightToLeftWithFade,
  ),

  GetPage(
    name: RoutePaths.profile,
    page: () => const ProfileScreen(),
    transition: Transition.cupertinoDialog,
    binding: ProfileBinding(),
    fullscreenDialog: true,
  ),

];