import 'package:shared_preferences/shared_preferences.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/globals/app_state.dart';
import 'package:railmates/pages/city_search_page.dart';
import 'package:railmates/pages/compatibility_questions_page.dart';
import 'package:railmates/pages/country_search_page.dart';
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
    return ChangeNotifierProvider<GlobalState>(
      create: (context) => GlobalState(),
      child: ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        builder: (context, child) {
          return MaterialApp(
            title: GlobalState.of(context).localizations.appTitle,
            theme: AppState.of(context).theme,
            routes: {
              'CitySearchPage': (context) => const CitySearchPage(),
              'CompatibilityQuestionsPage': (context) =>
                  const CompatibilityQuestionsPage(),
              'CountrySearchPage': (context) => const CountrySearchPage(),
              'ForgotPasswordPage': (context) => const ForgotPasswordPage(),
              'LoginPage': (context) => const LoginPage(),
              'OtpPage': (context) => const OtpPage(),
              'ProfilePage': (context) => const ProfilePage(),
              'RegisterPage': (context) => const RegisterPage(),
            },
            initialRoute: 'LoginPage',
          );
        },
      ),
    );
  }
}
