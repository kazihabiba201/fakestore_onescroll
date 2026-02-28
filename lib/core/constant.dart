class Persistence {
  static const String isLogged = "IS_LOGGED";
  static const String user = "USER";
  static const String pass = "PASS";
  static const String isInitialFirst = "IS_INITIAL";
  static const String token = "TOKEN";
}

class WebService {
  static const String urlBase = "https://fakestoreapi.com";
  static const String urlFallBack = "https://www.setra.com/hubfs/Sajni/crc_error.jpg";
}

class EndPoint {
  static const String login = "/auth/login";
  static const String singIn = "/users";
  static const String products = "/products";
  static const String category = "/products/category/";
  static const String profile = "/users/1";
}

class AppSizes {
  static const double searchBarHeight = 45;
  static const double flashBannerHeight = 40;
  static const double gridSpacing = 12;
  static const int gridCrossAxisCount = 2;
  static const double gridAspectRatio = 1.5;
}


class TokenJwk {
  static String jwk = '';
}
