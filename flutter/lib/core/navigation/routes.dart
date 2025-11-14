import 'package:go_router/go_router.dart';
import 'package:blockin/app/auth/routes.dart';
import 'package:blockin/app/auth/ui/screens/reset_password_screen.dart';
import 'package:blockin/app/auth/ui/screens/welcome_screen.dart';
import 'package:blockin/app/board/routes.dart';
import 'package:blockin/app/board/ui/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GoRouter router = GoRouter(
  initialLocation: WelcomeScreen.routeName,
  routes: [...authRoutes, ...boardRoutes],
  redirect: (context, state) {
    // Allow access to reset password screen during password recovery
    if (state.uri.path == ResetPasswordScreen.routeName) {
      return null;
    }

    final isAuthenticated = Supabase.instance.client.auth.currentUser != null;
    if (isAuthenticated) {
      return TetrisDemoScreen.routeName;
    }
    return null;
  },
);
