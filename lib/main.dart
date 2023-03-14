import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/src/app.dart';
import 'package:watch/src/providers/provider_observer.dart';

import 'firebase_options.dart';
import 'src/providers/local_storage_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefsInstance = await SharedPreferences.getInstance();
  Animate.restartOnHotReload = true;
  runApp(
    ProviderScope(
      key: const Key('GlobalProviderScope'),
      overrides: [
        sharedPreferenceProvider.overrideWithValue(prefsInstance),
      ],
      observers: [ProviderLogger()],
      child: const MyApp(),
    ),
  );
}
