enum APP_PAGE {
  introScreen,
  splashScreen,
  home,
  login,
  register,
  otpScreen,
  itemDetailScreen,
  scannerScreen,
}

extension AppPageExtension on APP_PAGE {
  // create path for routes
  String get routePath {
    switch (this) {
      case APP_PAGE.home:
        return "/";

      case APP_PAGE.login:
        return "/login";

      case APP_PAGE.splashScreen:
        return "/splashScreen";

      case APP_PAGE.register:
        return "register";

      case APP_PAGE.itemDetailScreen:
        return "itemDetailScreen/:code";

      case APP_PAGE.scannerScreen:
        return "scannerScreen";

      default:
        return "/";
    }
  }

  // for named routes
  String get routeName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";

      case APP_PAGE.login:
        return "LOGIN";

      case APP_PAGE.splashScreen:
        return "SPLASHSCREEN";

      case APP_PAGE.register:
        return "REGISTER";

      case APP_PAGE.itemDetailScreen:
        return "ITEMDETAILSCREEN";

      case APP_PAGE.scannerScreen:
        return "SCANNERSCREEN";

      default:
        return "HOME";
    }
  }

  // for page titles to use on appbar
  String get routePageTitle {
    switch (this) {
      case APP_PAGE.home:
        return "Home";

      default:
        return "Home";
    }
  }
}
