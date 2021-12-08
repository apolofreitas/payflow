import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/models/boleto.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatelessWidget {
  final BoletoListController controller;
  final bool Function(Boleto)? where;

  const BoletoListWidget({
    Key? key,
    required this.controller,
    this.where,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final boletos = controller.boletos.where(where ?? (element) => true);

        if (boletos.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Ainda não temos nada para mostrar aqui",
              style: AppTextStyles.captionBody,
            ),
          );
        }

        return Column(
          children: boletos
              .map((boleto) => AnimatedCard(
                    direction: AnimatedCardDirection.right,
                    child: BoletoTileWidget(boleto: boleto),
                  ))
              .toList(),
        );
      },
    );
  }
}
