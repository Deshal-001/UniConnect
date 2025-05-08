import 'package:flutter/material.dart';

abstract class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? text;
  final Color? color;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final TextStyle? fontStyle;
  final Widget? iconRight;
  final Widget? iconLeft;
  final RichText? richTextWidget;

  const BaseButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.color,
    this.width,
    this.height,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fontStyle,
    this.iconRight,
    this.iconLeft,
    this.richTextWidget,
  });

  /// Abstract method to be implemented in concrete button widgets
  Widget buildButton(BuildContext context);

  @override
  Widget build(BuildContext context) => buildButton(context);
}
