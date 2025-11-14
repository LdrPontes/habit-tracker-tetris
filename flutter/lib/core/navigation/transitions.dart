import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Creates a slide from bottom transition page (iOS style)
///
/// This transition slides the page from the bottom of the screen,
/// similar to iOS modal presentations.
CustomTransitionPage slideFromBottomPage({
  required Widget child,
  required GoRouterState state,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Duration reverseTransitionDuration = const Duration(milliseconds: 300),
  bool opaque = true,
  bool fullscreenDialog = true,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
        child: child,
      );
    },
    transitionDuration: transitionDuration,
    reverseTransitionDuration: reverseTransitionDuration,
    opaque: opaque,
    fullscreenDialog: fullscreenDialog,
  );
}
