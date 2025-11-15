import 'package:blockin/app/onboarding/ui/screens/onboarding_finished_screen.dart';
import 'package:blockin/app/onboarding/ui/screens/onboarding_screen.dart';
import 'package:blockin/app/onboarding/ui/screens/start_onboarding_screen.dart';
import 'package:blockin/core/navigation/redirects.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> onboardingRoutes = [
  GoRoute(
    path: StartOnboardingScreen.routeName,
    redirect: requireAuth,
    builder: (context, state) => const StartOnboardingScreen(),
  ),
  GoRoute(
    path: OnboardingScreen.routeName,
    redirect: requireAuth,
    builder: (context, state) => const OnboardingScreen(),
  ),
  GoRoute(
    path: OnboardingFinishedScreen.routeName,
    redirect: requireAuth,
    builder: (context, state) => const OnboardingFinishedScreen(),
  ),
];
