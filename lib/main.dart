import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receipt_editor/helpers/dependencies.dart' as dep;
import 'package:receipt_editor/helpers/permission_handler.dart';
import 'package:receipt_editor/routes/routes.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  bool storageGranted =
      await requestPermission(Permission.manageExternalStorage);
  bool bluetoothGranted = await requestPermission(Permission.bluetoothConnect);

  if (storageGranted && bluetoothGranted) {
    print("All permissions granted!");
  } else {
    print("Some permissions were denied.");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Receipt Editor',
      theme: ThemeData(
        primaryColor: AppColors.color1,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.color1,
          secondary: AppColors.color2,
        ),
      ),
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
    );
  }
}
