import 'package:blockin/app/onboarding/ui/screens/start_onboarding_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:blockin/app/auth/routes.dart';
import 'package:blockin/app/auth/ui/screens/reset_password_screen.dart';
import 'package:blockin/app/auth/ui/screens/welcome_screen.dart';
import 'package:blockin/app/board/routes.dart';
import 'package:blockin/app/onboarding/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GoRouter router = GoRouter(
  initialLocation: getInitialRoute(),
  routes: [...authRoutes, ...boardRoutes, ...onboardingRoutes],
  redirect: (context, state) {
    // Allow access to reset password screen during password recovery
    if (state.uri.path == ResetPasswordScreen.routeName) {
      return null;
    }

    return null;
  },
);

String? getInitialRoute() {
  final isAuthenticated = Supabase.instance.client.auth.currentUser != null;
  if (!isAuthenticated) {
    return WelcomeScreen.routeName;
  }
  return StartOnboardingScreen.routeName;
}
