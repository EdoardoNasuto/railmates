import 'package:shared_preferences/shared_preferences.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railmates/globals/app_state.dart';
import 'package:railmates/pages/city_research_page.dart';
import 'package:railmates/pages/forgot_password_page.dart';
import 'package:railmates/pages/login_page.dart';
import 'package:railmates/pages/otp_page.dart';
import 'package:railmates/pages/profile_page.dart';
import 'package:railmates/pages/register_page.dart';

@NowaGenerated()
late final SharedPreferences sharedPrefs;

@NowaGenerated()
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  await SupabaseService().initialize();
  runApp(const MyApp());
}

@NowaGenerated({'visibleInNowa': false})
class MyApp extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      builder: (context, child) => MaterialApp(
        theme: AppState.of(context).theme,
        routes: {
          'CityResearchPage': (context) => const CityResearchPage(),
          'ForgotPasswordPage': (context) => const ForgotPasswordPage(),
          'LoginPage': (context) => const LoginPage(),
          'OtpPage': (context) => const OtpPage(),
          'ProfilePage': (context) => const ProfilePage(),
          'RegisterPage': (context) => const RegisterPage(),
        },
        initialRoute: 'LoginPage',
      ),
    );
  }
}
