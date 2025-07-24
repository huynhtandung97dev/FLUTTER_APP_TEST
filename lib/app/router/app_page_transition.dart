import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPageTransition {
  static CustomTransitionPage build({required Widget child, required LocalKey key}) {
    return CustomTransitionPage(
      key: key,
      child: child,
      fullscreenDialog: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
