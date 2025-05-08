import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageItem extends StatelessWidget {
  final String assetPath;
  final String languageName;
  final double iconSize;
  final TextStyle? textStyle;
  final MainAxisAlignment alignment;

  const LanguageItem({
    super.key,
    required this.assetPath,
    required this.languageName,
    this.iconSize = 12,
    this.textStyle,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        SvgPicture.asset(
          assetPath,
          height: iconSize,
          width: iconSize,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(width: 5),
        Text(
          languageName,
          style: textStyle ??
              const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
