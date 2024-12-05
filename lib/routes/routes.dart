import 'package:get/get.dart';
import 'package:receipt_editor/screens/main_screens/home_screen.dart';
import 'package:receipt_editor/screens/main_screens/about_screen.dart';
import 'package:receipt_editor/screens/main_screens/template_screen.dart';
import 'package:receipt_editor/screens/temp_forms/collect+_form.dart';
import 'package:receipt_editor/screens/temp_forms/dpd_form.dart';
import 'package:receipt_editor/screens/temp_forms/parcel_force_form.dart';
import 'package:receipt_editor/screens/temp_forms/rm_form.dart';

import '../screens/splash_screen.dart';
import '../screens/temp_forms/collect_plus_a4_form.dart';
import '../screens/temp_forms/yodel_form.dart';


class AppRoutes {
  static const String splashScreen = '/splash-screen';
  static const String homeScreen = '/home-screen';
  static const String templateScreen = '/template-screen';
  static const String aboutScreen = '/about-screen';
  static const String collectPlusForm = '/collect-plus-form';
  static const String collectPlusA4Form = '/collect-plus-a4-form';
  static const String dpdForm = '/dpd-form';
  static const String rmForm = '/rm-form';
  static const String yodelForm = '/yodel-form';
  static const String parcelForceForm = '/parcel-force-form';




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
    GetPage(
      name: collectPlusA4Form,
      page: () {
        return const CollectPlusA4Form();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: dpdForm,
      page: () {
        return const DpdForm();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: rmForm,
      page: () {
        return const RmForm();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: yodelForm,
      page: () {
        return const YodelForm();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: parcelForceForm,
      page: () {
        return const ParcelForceForm();
      },
      transition: Transition.fadeIn,
    ),

  ];
}
