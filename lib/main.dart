import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_upload_test/src/routing/app_router.dart';
import 'package:image_upload_test/src/utils/file_utils.dart';
import 'package:image_upload_test/src/utils/permission_utils.dart';
import 'package:image_upload_test/src/utils/persist_data_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PersistDataUtils.init();

  requestStoragePermission();
  androidRequestDirectoryAccess();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: appRouter);
  }
}
