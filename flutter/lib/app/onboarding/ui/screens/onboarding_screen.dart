import 'package:blockin/app/onboarding/ui/components/templates/onboarding_notification_template.dart';
import 'package:blockin/app/onboarding/ui/components/templates/onboarding_questions_template.dart';
import 'package:blockin/app/onboarding/ui/components/templates/onboarding_screen_template.dart';
import 'package:blockin/app/onboarding/ui/screens/onboarding_finished_screen.dart';
import 'package:blockin/core/localization/localizations.dart';
import 'package:blockin/core/navigation/routes.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleBackPressed() {
    if (_currentStep > 1) {
      // Volta para o step anterior
      final previousPage =
          _currentStep - 2; // currentStep é 1-indexed, page é 0-indexed
      _pageController.animateToPage(
        previousPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      router.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenTemplate(
      totalSteps: 5,
      currentStep: _currentStep,
      onBackPressed: _handleBackPressed,
      steps: [
        OnboardingQuestionsTemplate(
          title: AppLocalizations.of(context)!.onboarding_first_question,
          options: [
            AppLocalizations.of(context)!.onboarding_first_question_option_1,
            AppLocalizations.of(context)!.onboarding_first_question_option_2,
            AppLocalizations.of(context)!.onboarding_first_question_option_3,
            AppLocalizations.of(context)!.onboarding_first_question_option_4,
            AppLocalizations.of(context)!.onboarding_first_question_option_5,
          ],
          onOptionSelected: (index) {},
          onContinuePressed: () {
            _pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        OnboardingQuestionsTemplate(
          title: AppLocalizations.of(context)!.onboarding_second_question,
          options: [
            AppLocalizations.of(context)!.onboarding_second_question_option_1,
            AppLocalizations.of(context)!.onboarding_second_question_option_2,
            AppLocalizations.of(context)!.onboarding_second_question_option_3,
            AppLocalizations.of(context)!.onboarding_second_question_option_4,
            AppLocalizations.of(context)!.onboarding_second_question_option_5,
            AppLocalizations.of(context)!.onboarding_second_question_option_6,
            AppLocalizations.of(context)!.onboarding_second_question_option_7,
          ],
          allowMultipleSelection: false,
          onOptionSelected: (index) {},
          onContinuePressed: () {
            _pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        OnboardingQuestionsTemplate(
          title: AppLocalizations.of(context)!.onboarding_third_question,
          options: [
            AppLocalizations.of(context)!.onboarding_third_question_option_1,
            AppLocalizations.of(context)!.onboarding_third_question_option_2,
            AppLocalizations.of(context)!.onboarding_third_question_option_3,
            AppLocalizations.of(context)!.onboarding_third_question_option_4,
            AppLocalizations.of(context)!.onboarding_third_question_option_5,
            AppLocalizations.of(context)!.onboarding_third_question_option_6,
            AppLocalizations.of(context)!.onboarding_third_question_option_7,
          ],
          onOptionSelected: (index) {},
          onContinuePressed: () {
            _pageController.animateToPage(
              3,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        OnboardingQuestionsTemplate(
          title: AppLocalizations.of(context)!.onboarding_fourth_question,
          options: [
            AppLocalizations.of(context)!.onboarding_fourth_question_option_1,
            AppLocalizations.of(context)!.onboarding_fourth_question_option_2,
          ],
          allowMultipleSelection: false,
          onOptionSelected: (index) {},
          onContinuePressed: () {
            _pageController.animateToPage(
              4,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        OnboardingNotificationTemplate(
          onContinuePressed: () {
            router.go(OnboardingFinishedScreen.routeName);
          },
        ),
      ],
      pageController: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentStep = index + 1;
        });
      },
    );
  }
}
