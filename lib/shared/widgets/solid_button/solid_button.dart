import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class SolidButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final bool variantPrimary;

  const SolidButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
    this.variantPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: variantPrimary ? AppColors.primary : AppColors.shape,
        padding: const EdgeInsets.all(18),
        shape: variantPrimary
            ? null
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(
                  color: AppColors.stroke,
                  width: 1,
                ),
              ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: variantPrimary
            ? AppTextStyles.buttonBackground
            : AppTextStyles.buttonGray,
      ),
    );
  }
}
