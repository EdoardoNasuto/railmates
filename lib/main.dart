import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:railmates/firebase_options.dart';
import 'package:railmates/firebase/notification_service.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/globals/app_state.dart';
import 'package:railmates/globals/router.dart';

@NowaGenerated()
late final SharedPreferences sharedPrefs;

@NowaGenerated()
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.initialize();
  await SupabaseService().initialize();
  runApp(const MyApp());
}

@NowaGenerated({'visibleInNowa': false})
class MyApp extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalState>(
      create: (context) => GlobalState(),
      child: ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        builder: (context, child) => MaterialApp.router(
          title: GlobalState.of(context).localizations.appTitle,
          theme: AppState.of(context).theme,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
