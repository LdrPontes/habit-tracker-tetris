import 'package:go_router/go_router.dart';
import 'package:blockin/app/auth/ui/screens/sign_in_screen.dart';
import 'package:blockin/app/auth/ui/screens/sign_up_screen.dart';
import 'package:blockin/app/auth/ui/screens/forgot_password_screen.dart';
import 'package:blockin/app/auth/ui/screens/reset_password_screen.dart';
import 'package:blockin/app/auth/ui/screens/welcome_screen.dart';
import 'package:blockin/app/auth/ui/screens/check_email_screen.dart';
import 'package:blockin/core/navigation/transitions.dart';

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
    builder: (context, state) => const ResetPasswordScreen(),
  ),
  GoRoute(
    path: WelcomeScreen.routeName,
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: CheckEmailScreen.routeName,
    pageBuilder: (context, state) {
      final email = state.uri.queryParameters['email'] ?? '';
      return slideFromBottomPage(
        child: CheckEmailScreen(email: email),
        state: state,
      );
    },
  ),
];
