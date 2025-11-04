import 'package:go_router/go_router.dart';
import 'package:starter/app/auth/routes.dart';
import 'package:starter/app/auth/ui/screens/sign_in_screen.dart';

GoRouter router = GoRouter(
  initialLocation: SignInScreen.routeName,
  routes: [...authRoutes],
);
