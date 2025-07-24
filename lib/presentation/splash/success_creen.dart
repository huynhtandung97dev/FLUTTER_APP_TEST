import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/screenutil_extension.dart';
import 'package:flutter_app_test/presentation/product/screens/product_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SuccessCreen extends StatefulWidget {
  const SuccessCreen({super.key});

  @override
  State<SuccessCreen> createState() => _SuccessCreenState();
}

class _SuccessCreenState extends State<SuccessCreen> {
  get splash => Center(child: LottieBuilder.asset("assets/Lottie/success.json", repeat: false));

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        context.goNamed('productList');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSplashScreen(
        splash: splash,
        nextScreen: ProductListScreen(),
        splashIconSize: 248.r,
        animationDuration: Duration(milliseconds: 1000),
        backgroundColor: const Color.fromARGB(255, 196, 199, 236),
      ),
    );
  }
}
