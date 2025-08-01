import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
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
    final radius = BorderRadius.circular(borderRadius ?? 24);
    final border = Border.all(
      color: borderColor ?? buttonColor,
      width: borderWidth ?? 2,
    );

    final isDisabled = isLoading || !(enable ?? true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GestureDetector(
        onTap: isDisabled ? null : onPressed,
        child: Opacity(
          opacity: (enable ?? true) ? 1.0 : 0.6,
          child: LiquidGlass(
            shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(24)),
            settings: LiquidGlassSettings(
              ambientStrength: 0.7,
              lightAngle: 0.2 * 3.14,
              glassColor: isDisabled
                  ? buttonColor.withOpacity(0.90)
                  : Colors.white.withOpacity(0.10),
              blur: 12,
              thickness: 18,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: width ?? double.infinity,
              height: height ?? 60,
              decoration: BoxDecoration(
                color: isDisabled
                    ? buttonColor.withOpacity(0.90)
                    : Colors.transparent,
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
                                  TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDisabled
                                        ? Colors.white
                                        : buttonColor,
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
      ),
    );
  }
}