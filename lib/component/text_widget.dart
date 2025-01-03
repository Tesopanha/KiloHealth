import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int maxLines;

  const BigText({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 24,
    this.fontWeight = FontWeight.normal,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: TextDecoration.none,
      ).merge(GoogleFonts.notoSansKhmer()),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int maxLines;
  const SmallText(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.maxLines = 1,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: TextDecoration.none,
      ).merge(GoogleFonts.notoSansKhmer()),
    );
  }
}
