import 'package:get/get.dart';
import 'package:receipt_editor/screens/main_screens/home_screen.dart';
import 'package:receipt_editor/screens/main_screens/about_screen.dart';
import 'package:receipt_editor/screens/main_screens/template_screen.dart';
import 'package:receipt_editor/screens/temp_forms/collect+_form.dart';

import '../screens/splash_screen.dart';


class AppRoutes {
  static const String splashScreen = '/splash-screen';
  static const String homeScreen = '/home-screen';
  static const String templateScreen = '/template-screen';
  static const String aboutScreen = '/about-screen';
  static const String collectPlusForm = '/collect-plus-form';




  static final routes = [
    GetPage(
      name: splashScreen,
      page: () {
        return const SplashScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: homeScreen,
      page: () {
        return const HomeScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: templateScreen,
      page: () {
        return const TemplateScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: aboutScreen,
      page: () {
        return const AboutScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: collectPlusForm,
      page: () {
        return const CollectPlusForm();
      },
      transition: Transition.fadeIn,
    ),

  ];
}
