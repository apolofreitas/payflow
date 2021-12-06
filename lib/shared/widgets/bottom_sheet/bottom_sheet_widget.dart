import 'package:flutter/material.dart';
import 'package:payflow/shared/label_button_group/label_button_group.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class BottomSheetWidget extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final String title;
  final String subtitle;

  const BottomSheetWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.black.withOpacity(0.5),
          )),
          Container(
            color: AppColors.background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    bottom: 40,
                  ),
                  child: Text.rich(
                    TextSpan(
                        text: title,
                        style: AppTextStyles.buttonBoldHeading,
                        children: [
                          TextSpan(
                            text: "\n$subtitle",
                            style: AppTextStyles.buttonHeading,
                          )
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2,
                  ),
                  child: Column(
                    children: [
                      const Divider(
                        color: AppColors.stroke,
                        indent: 1,
                        height: 1,
                      ),
                      LabelButtonGroup(
                        enablePrimaryColor: true,
                        primaryLabel: primaryLabel,
                        primaryOnPressed: primaryOnPressed,
                        secondaryLabel: secondaryLabel,
                        secondaryOnPressed: secondaryOnPressed,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
