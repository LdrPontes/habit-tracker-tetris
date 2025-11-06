import 'package:go_router/go_router.dart';
import 'package:starter/app/auth/routes.dart';
import 'package:starter/app/auth/ui/screens/sign_in_screen.dart';
import 'package:starter/app/board/routes.dart';
import 'package:starter/app/board/ui/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GoRouter router = GoRouter(
  initialLocation: SignInScreen.routeName,
  routes: [...authRoutes, ...boardRoutes],
  redirect: (context, state) {
    final isAuthenticated = Supabase.instance.client.auth.currentUser != null;
    if (isAuthenticated) {
      return TetrisDemoScreen.routeName;
    }
  },
);
