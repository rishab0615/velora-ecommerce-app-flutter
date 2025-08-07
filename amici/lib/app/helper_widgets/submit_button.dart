import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'hex_color.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const Button({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(1.h);
    return Container(
      height: 7.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor("#1B51B8"),
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}









