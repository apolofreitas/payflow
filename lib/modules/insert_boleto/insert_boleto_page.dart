import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/widgets/label_button_group/label_button_group.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/text_input/text_input_widget.dart';

class InsertBoleto extends StatefulWidget {
  final String? barcode;
  const InsertBoleto({Key? key, this.barcode}) : super(key: key);

  @override
  State<InsertBoleto> createState() => _InsertBoletoState();
}

class _InsertBoletoState extends State<InsertBoleto> {
  final controller = InsertBoletoController();
  final moneyTextInputController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );
  final dueDateTextInputController = MaskedTextController(mask: "00/00/0000");
  final barcodeTextInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.barcode != null) {
      barcodeTextInputController.text = widget.barcode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 24,
                ),
                child: Center(
                  child: SizedBox(
                    width: 192,
                    child: Text(
                      'Preencha os dados do boleto',
                      style: AppTextStyles.titleBoldHeading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextInputWidget(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      validator: controller.validateName,
                      onChanged: (value) {
                        controller.name = value;
                      },
                    ),
                    TextInputWidget(
                      controller: dueDateTextInputController,
                      label: "Vencimento",
                      icon: FontAwesomeIcons.timesCircle,
                      validator: controller.validateDueDate,
                      onChanged: (value) {
                        controller.dueDate = value;
                      },
                    ),
                    TextInputWidget(
                      controller: moneyTextInputController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => controller.validateValue(
                        moneyTextInputController.numberValue,
                      ),
                      onChanged: (value) {
                        controller.value = moneyTextInputController.numberValue;
                      },
                    ),
                    TextInputWidget(
                      controller: barcodeTextInputController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      validator: controller.validateBarcode,
                      onChanged: (value) {
                        controller.barcode = value;
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: LabelButtonGroup(
        enableSecondaryColor: true,
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Get.back();
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () async {
          if (controller.form.validate() == false) return;
          await controller.registerBoleto();
          Get.back();
        },
      ),
    );
  }
}
