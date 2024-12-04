import 'package:flutter/foundation.dart'; // For kIsWeb check
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receipt_editor/helpers/dependencies.dart' as dep;
import 'package:receipt_editor/routes/routes.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'helpers/web_permission_handler.dart'; // Web-specific permission handler

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  bool allPermissionsGranted = false;

  if (kIsWeb) {
    // Web-specific permission handling
    final webPermissionHandler = WebPermissionHandler();
    bool storageGranted = await webPermissionHandler.requestPermission('storage');
    bool bluetoothGranted = await webPermissionHandler.requestPermission('bluetooth');

    allPermissionsGranted = storageGranted && bluetoothGranted;

    if (allPermissionsGranted) {
      print("All web permissions granted!");
    } else {
      print("Some web permissions were denied or not required.");
    }
  } else {
    // Native-specific permission handling
    bool storageGranted = await requestPermission(Permission.manageExternalStorage);
    bool bluetoothGranted = await requestPermission(Permission.bluetoothConnect);

    allPermissionsGranted = storageGranted && bluetoothGranted;

    if (allPermissionsGranted) {
      print("All native permissions granted!");
    } else {
      print("Some native permissions were denied.");
    }
  }

  runApp(const MyApp());
}

/// Generic permission handler for native platforms (Android/iOS)
Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    return result.isGranted;
  }
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