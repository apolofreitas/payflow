import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_info/boleto_info_widget.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';

class MyBoletosPage extends StatefulWidget {
  const MyBoletosPage({Key? key}) : super(key: key);

  @override
  State<MyBoletosPage> createState() => _MyBoletosPageState();
}

class _MyBoletosPageState extends State<MyBoletosPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.primary,
                height: 40,
                width: double.maxFinite,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Obx(
                    () => AnimatedCard(
                      direction: AnimatedCardDirection.top,
                      child: BoletoInfoWidget(
                        size: controller.boletos.length,
                      ),
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Row(
              children: [
                Text(
                  "Meus boletos",
                  style: AppTextStyles.titleBoldHeading,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
            indent: 24,
            endIndent: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoListWidget(
              controller: controller,
              where: (boleto) => !boleto.wasPaid,
            ),
          )
        ],
      ),
    );
  }
}
