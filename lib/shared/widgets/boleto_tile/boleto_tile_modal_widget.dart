import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/models/boleto.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';
import 'package:payflow/shared/widgets/solid_button/solid_button.dart';

class BoletoTileModalWidget extends StatelessWidget {
  final Boleto boleto;

  const BoletoTileModalWidget({
    Key? key,
    required this.boleto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: 44,
              height: 2,
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: SizedBox(
              width: 220,
              child: Text.rich(
                TextSpan(
                  text: "O boleto ",
                  style: AppTextStyles.titleRegularHeading,
                  children: [
                    TextSpan(
                      text: "${boleto.name} ",
                      style: AppTextStyles.titleBoldHeading,
                    ),
                    const TextSpan(text: "no valor de R\$ "),
                    TextSpan(
                      text: "${boleto.value} ",
                      style: AppTextStyles.titleBoldHeading,
                    ),
                    const TextSpan(text: "foi pago?"),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SolidButton(
                      buttonText: "Ainda não",
                      onPressed: () async {
                        if (boleto.wasPaid) {
                          boleto.wasPaid = false;
                          await boleto.save();
                        }
                        Get.back();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SolidButton(
                      buttonText: "Sim",
                      variantPrimary: true,
                      onPressed: () async {
                        if (!boleto.wasPaid) {
                          boleto.wasPaid = true;
                          await boleto.save();
                        }
                        Get.back();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.stroke,
            thickness: 1,
            height: 1,
          ),
          LabelButton(
            label: "Deletar boleto",
            style: AppTextStyles.buttonDelete,
            onPressed: () async {
              await boleto.delete();
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
