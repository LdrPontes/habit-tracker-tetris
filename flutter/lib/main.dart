import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starter/app/auth/ui/screens/reset_password_screen.dart';
import 'package:starter/app/auth/ui/screens/sign_in_screen.dart';
import 'package:starter/config/env.dart';
import 'package:starter/core/app_injections.dart';
import 'package:starter/core/localization/localizations.dart';
import 'package:starter/core/navigation/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.SUPABASE_URL,
    anonKey: Env.SUPABASE_ANON_KEY,
  );

  // Start dependency injection modules
  startInjectionModules();
  await getIt.allReady();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<AuthState> authSubscription;

  @override
  void initState() {
    super.initState();
    authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      final AuthChangeEvent event = data.event;

      if (event == AuthChangeEvent.passwordRecovery) {
        router.push(ResetPasswordScreen.routeName);
      }

      if (event == AuthChangeEvent.signedOut) {
        router.go(SignInScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    authSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Supabase.instance.client.auth.signOut();
    return ToastificationWrapper(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Starter',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
