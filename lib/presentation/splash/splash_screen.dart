import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/screenutil_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showSuccess = false;

  Timer? _timer1;
  Timer? _timer2;

  @override
  void initState() {
    super.initState();

    _timer1 = Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        setState(() => showSuccess = true);
        _timer2 = Timer(const Duration(milliseconds: 2500), () {
          if (mounted) context.go('/products');
        });
      }
    });
  }

  @override
  void dispose() {
    _timer1?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 211, 250),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child:
              showSuccess
                  ? Lottie.asset(
                    'assets/Lottie/success.json',
                    key: const ValueKey('success'),
                    width: 148.w,
                    height: 148.h,
                    repeat: false,
                  )
                  : Lottie.asset(
                    'assets/Lottie/loading.json',
                    key: const ValueKey('loading'),
                    width: 148.w,
                    height: 148.h,
                  ),
        ),
      ),
    );
  }
}
