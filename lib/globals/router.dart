import 'package:go_router/go_router.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/pages/home_page.dart';
import 'package:railmates/pages/login_page.dart';
import 'package:railmates/pages/register_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:railmates/pages/otp_page.dart';
import 'package:railmates/pages/forgot_password_page.dart';
import 'package:railmates/pages/profile_page.dart';
import 'package:railmates/pages/profile_creation_page.dart';
import 'package:railmates/pages/city_search_page.dart';
import 'package:railmates/pages/country_search_page.dart';
import 'package:railmates/pages/compatibility_destinations_page.dart';
import 'package:railmates/pages/compatibility_essentials_page.dart';
import 'package:railmates/pages/compatibility_group_page.dart';
import 'package:railmates/pages/compatibility_questions_page.dart';
import 'package:railmates/pages/compatibility_ready_page.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    const unauthAllowed = const <String>{
      '/otp',
      '/register',
      '/forgot-password',
    };
    final String current = state.matchedLocation;
    if (unauthAllowed.contains(current)) {
      return null;
    }
    if (!SupabaseService().isConnected()) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      name: 'otp',
      path: '/otp',
      builder: (context, state) {
        final Map<String, String> qp = state.uri.queryParameters;
        final String email = qp['email'] ?? '';
        OtpType otpType = OtpType.signup;
        final otpStr = qp['otpType'];
        if (otpStr != null) {
          otpType = otpStr == 'recovery' ? OtpType.recovery : OtpType.signup;
        }
        return OtpPage(email: email, otpType: otpType);
      },
    ),
    GoRoute(
      name: 'forgot_password',
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      name: 'profile_create',
      path: '/profile/create',
      builder: (context, state) => const ProfileCreationPage(),
    ),
    GoRoute(
      name: 'city_search',
      path: '/city-search',
      builder: (context, state) => const CitySearchPage(),
    ),
    GoRoute(
      name: 'country_search',
      path: '/country-search',
      builder: (context, state) => const CountrySearchPage(),
    ),
    GoRoute(
      name: 'compatibility_destinations',
      path: '/compatibility/destinations',
      builder: (context, state) => const CompatibilityDestinationsPage(),
    ),
    GoRoute(
      name: 'compatibility_essentials',
      path: '/compatibility/essentials',
      builder: (context, state) => const CompatibilityEssentialsPage(),
    ),
    GoRoute(
      name: 'compatibility_group',
      path: '/compatibility/group',
      builder: (context, state) => const CompatibilityGroupPage(),
    ),
    GoRoute(
      name: 'compatibility_questions',
      path: '/compatibility/questions',
      builder: (context, state) {
        final Map<String, String> qp = state.uri.queryParameters;
        int questionPos = int.tryParse(qp['questionPos'] ?? '') ?? 1;
        int questionsCount = int.tryParse(qp['questionsCount'] ?? '') ?? 20;
        return CompatibilityQuestionsPage(
          questionPos: questionPos,
          questionsCount: questionsCount,
        );
      },
    ),
    GoRoute(
      name: 'compatibility_ready',
      path: '/compatibility/ready',
      builder: (context, state) => const CompatibilityReadyPage(),
    ),
  ],
);
