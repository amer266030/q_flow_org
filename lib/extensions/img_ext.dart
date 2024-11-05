import 'package:flutter/cupertino.dart';

extension Img on ImageProvider {
  // Logo
  static const logo = AssetImage('assets/logo/logo.png');
  static const logoOrange = AssetImage('assets/logo/logo_orange.png');

  //loading
  static const loading = AssetImage('assets/logo/loading_org.gif');

  //splash
  static const splashLight = AssetImage('assets/splash/org_splash.gif');
  static const splashDark = AssetImage('assets/splash/org_splash_dark.gif');

  static get logoTurquoise => null;
}
