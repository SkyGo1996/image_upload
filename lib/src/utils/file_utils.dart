import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

Future<void> androidRequestDirectoryAccess() async {
  final intent = AndroidIntent(
    action: "android.intent.action.OPEN_DOCUMENT_TREE",
    flags: [
      Flag.FLAG_GRANT_READ_URI_PERMISSION,
      Flag.FLAG_GRANT_PERSISTABLE_URI_PERMISSION,
      Flag.FLAG_GRANT_WRITE_URI_PERMISSION,
    ],
  );

  await intent.launch();
}
