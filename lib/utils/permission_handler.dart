import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  final status = await Permission.storage.request();

  if (status.isGranted) {
    print('Storage permission granted.');
  } else if (status.isDenied) {
    print('Storage permission denied.');
    // Optionally, you can show a dialog or redirect users to settings.
  } else if (status.isPermanentlyDenied) {
    print('Storage permission permanently denied.');
    openAppSettings(); // Redirect to app settings to enable permission manually.
  }
}
