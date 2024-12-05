import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission) async {
  AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;

  // For Android 12 and above (SDK >= 31), request Bluetooth Connect permission
  if (build.version.sdkInt >= 31 && permission == Permission.bluetoothConnect) {
    var result = await Permission.bluetoothConnect.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // Handle Manage External Storage for SDK >= 30
  if (build.version.sdkInt >= 30 && permission == Permission.manageExternalStorage) {
    var result = await Permission.manageExternalStorage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // Handle other permissions
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    return result.isGranted;
  }
}
