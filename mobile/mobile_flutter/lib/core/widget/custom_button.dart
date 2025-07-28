import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
    super.enable,
  });

  @override
  Widget buildButton(BuildContext context) {
    final buttonColor = color ?? const Color(AppSolidColors.primary);
    final disabledColor = Colors.grey.shade400;
    final radius = BorderRadius.circular(borderRadius ?? 8);
    final border = Border.all(
      color: borderColor ?? Colors.transparent,
      width: borderWidth ?? 0,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GestureDetector(
        onTap: (isLoading || !(enable ?? true)) ? null : onPressed,
        child: Opacity(
          opacity: (enable ?? true) ? 1.0 : 0.6,
          child: Container(
            width: width ?? double.infinity,
            height: height ?? 60,
            decoration: BoxDecoration(
              color: (enable ?? true)
                  ? (isLoading ? buttonColor.withOpacity(0.7) : buttonColor)
                  : disabledColor,
              borderRadius: radius,
              border: border,
            ),
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: Lottie.asset(
                      'assets/animations/loadingfinal.json',
                      width: 120,
                      height: 120,
                      fit: BoxFit.scaleDown,
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
                            text ?? '',
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
      ),
    );
  }
}
