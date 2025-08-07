import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final int? maxlines;
  final Color? color;
  final FontWeight bold;
  final FontStyle? style;
  final TextAlign? alignment;
  final TextDecoration? decoration;
  final TextOverflow? overflow;

  const TextWidget(
      {Key? key,
        required this.text,
        required this.size,
        this.color,
        required this.bold,
        this.alignment,
        this.decoration,
        this.style,
        this.overflow, this.maxlines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          for (int i = 0; i < text.length; i++)
            TextSpan(
              text: text[i],
              style: TextStyle(
                color: color,
                fontSize: size,
                fontWeight: bold,
                fontFamily: text[i] == "₦" ? "" : "Poppins",
                decoration: decoration,
                fontStyle: style,
              ),
            ),
        ],
      ),
      textAlign: alignment,
      maxLines: maxlines,
      overflow: overflow,
    );
  }
}
