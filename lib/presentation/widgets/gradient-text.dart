import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextType {
  normal,
  heading,
  subtitle,
  caption,
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextType textType;
  final TextStyle? customTextStyle;
  final TextAlign textAlign;

  const GradientText({
    super.key,
    required this.text,
    required this.gradient,
    this.textType = TextType.normal,
    this.textAlign = TextAlign.center,
    this.customTextStyle,
  });

  TextStyle getDefaultTextStyle(TextType textType) {
    switch (textType) {
      case TextType.heading:
        return GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
      case TextType.subtitle:
        return GoogleFonts.montserrat(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
      case TextType.caption:
        return GoogleFonts.montserrat(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        );
      case TextType.normal:
      default:
        return GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = getDefaultTextStyle(textType);

    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        textAlign: textAlign,
        style: customTextStyle ?? defaultTextStyle,
      ),
    );
  }
}
