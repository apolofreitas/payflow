import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_modal_widget.dart';

class BoletoTileWidget extends StatelessWidget {
  final Boleto boleto;
  const BoletoTileWidget({Key? key, required this.boleto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => BoletoTileModalWidget(boleto: boleto),
        );
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(
        boleto.name,
        style: AppTextStyles.titleListTile,
      ),
      subtitle: Text(
        "Vence em ${boleto.dueDate}",
        style: AppTextStyles.captionBody,
      ),
      trailing: Text.rich(
        TextSpan(
          text: "R\$ ",
          style: AppTextStyles.trailingRegular,
          children: [
            TextSpan(
              text: boleto.value.toStringAsFixed(2),
              style: AppTextStyles.trailingBold,
            ),
          ],
        ),
      ),
    );
  }
}
