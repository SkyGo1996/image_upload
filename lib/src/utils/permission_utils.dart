import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> requestStoragePermission() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    final status =
        (Platform.isAndroid && androidInfo.version.sdkInt > 32)
            ? await Permission.photos.request()
            : await Permission.storage.request();

    return status;
  } else {
    return PermissionStatus.granted;
  }
}

Future<PermissionStatus> requestFullStoragePermission() async {
  if (Platform.isAndroid) {
    return await Permission.manageExternalStorage.request();
  } else {
    return PermissionStatus.granted;
  }
}
