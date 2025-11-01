import 'package:go_router/go_router.dart';
import 'package:starter/app/auth/ui/screens/sign_in_screen.dart';

GoRouter router = GoRouter(
  initialLocation: SignInScreen.routeName,
  routes: [
    GoRoute(
      path: SignInScreen.routeName,
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
