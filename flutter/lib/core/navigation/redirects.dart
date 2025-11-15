import 'package:blockin/app/auth/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Redirects to sign-in if user is not authenticated
String? requireAuth(BuildContext context, GoRouterState state) {
  final isAuthenticated = Supabase.instance.client.auth.currentUser != null;

  if (!isAuthenticated) {
    return WelcomeScreen.routeName;
  }
  return null;
}
