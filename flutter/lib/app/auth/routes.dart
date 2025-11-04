import 'package:go_router/go_router.dart';
import 'package:starter/app/auth/ui/screens/sign_in_screen.dart';
import 'package:starter/app/auth/ui/screens/sign_up_screen.dart';
import 'package:starter/app/auth/ui/screens/forgot_password_screen.dart';
import 'package:starter/app/auth/ui/screens/reset_password_screen.dart';
import 'package:starter/core/navigation/redirects.dart';

final authRoutes = [
  GoRoute(
    path: SignInScreen.routeName,
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: SignUpScreen.routeName,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    path: ForgotPasswordScreen.routeName,
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
  GoRoute(
    path: ResetPasswordScreen.routeName,
    redirect: requireAuth,
    builder: (context, state) => const ResetPasswordScreen(),
  ),
];
