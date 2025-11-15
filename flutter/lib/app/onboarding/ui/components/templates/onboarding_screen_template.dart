import 'package:blockin/app/shared/ui/components/molecules/blockin_app_bar.dart';
import 'package:flutter/material.dart';

class OnboardingScreenTemplate extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final List<Widget> steps;
  final PageController pageController;
  final Function(int) onPageChanged;
  final VoidCallback? onBackPressed;

  const OnboardingScreenTemplate({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.steps,
    required this.pageController,
    required this.onPageChanged,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BlockinAppBar(
        totalSteps: totalSteps,
        currentStep: currentStep,
        onBackPressed: onBackPressed,
      ),
      body: PageView.builder(
        itemCount: steps.length,
        physics: const NeverScrollableScrollPhysics(),
        pageSnapping: false,
        controller: pageController,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return steps[index];
        },
      ),
    );
  }
}
