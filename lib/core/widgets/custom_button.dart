import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/screenutil_extension.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? backgroundColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? padding;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    double? borderRadius,
    this.backgroundColor,
    double? fontSize,
    this.fontWeight = FontWeight.w500,
    this.padding,
  }) : borderRadius = borderRadius ?? 32.0.r,
       fontSize = fontSize ?? 16.0.sp;

  Widget get _button {
    final style =
        backgroundColor != null || padding != null || borderRadius != 32.0.r
            ? ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
              padding: padding,
            )
            : null;

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: _button);
    }

    return _button;
  }
}
