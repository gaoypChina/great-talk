import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:great_talk/common/run_app.dart';
import 'flavors.dart';

void main() async {
  await runZonedGuarded(() async {
    F.appFlavor = Flavor.dev;
    // Dartのエラーを報告
    await RunApp.runMyApp(F.appFlavor!);
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
