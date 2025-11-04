import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starter/app/auth/ui/screens/sign_in_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Redirects to sign-in if user is not authenticated
String? requireAuth(BuildContext context, GoRouterState state) {
  final isAuthenticated = Supabase.instance.client.auth.currentUser != null;

  if (!isAuthenticated) {
    return SignInScreen.routeName;
  }

  return null;
}
