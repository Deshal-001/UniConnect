import 'package:flutter/material.dart';
import 'package:uniconnect_app/core/constants/solid_colors.dart';
import 'base_button.dart';

class CustomButton extends BaseButton {
  const CustomButton({
    super.key,
    required super.onPressed,
    super.text,
    super.isLoading,
    super.color,
    super.width,
    super.height,
    super.borderColor,
    super.borderWidth,
    super.borderRadius,
    super.fontStyle,
    super.iconLeft,
    super.iconRight,
    super.richTextWidget,
  });

  @override
  Widget buildButton(BuildContext context) {
    final buttonColor = color ?? const Color(AppSolidColors.primary);
    final radius = BorderRadius.circular(borderRadius ?? 8);
    final border = Border.all(
      color: borderColor ?? Colors.transparent,
      width: borderWidth ?? 0,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 60,
          decoration: BoxDecoration(
            color: isLoading ? buttonColor.withOpacity(0.7) : buttonColor,
            borderRadius: radius,
            border: border,
          ),
          alignment: Alignment.center,
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconLeft != null) ...[
                      iconLeft!,
                      const SizedBox(width: 8),
                    ],
                    richTextWidget ??
                    Text(
                      text?? '',
                      style: fontStyle ??
                          const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    if (iconRight != null) ...[
                      const SizedBox(width: 8),
                      iconRight!,
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
