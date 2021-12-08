import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/shared/widgets/label_button_group/label_button_group.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';

class BarcodeScannePage extends StatefulWidget {
  const BarcodeScannePage({Key? key}) : super(key: key);

  @override
  _BarcodeScannePageState createState() => _BarcodeScannePageState();
}

class _BarcodeScannePageState extends State<BarcodeScannePage> {
  final controller = BarcodeScannerController(
    onScanBarcode: (barcode) {
      Get.offNamed(
        "/insert_boleto",
        arguments: {
          'barcode': barcode,
        },
      );
    },
  );

  @override
  void initState() {
    controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Obx(() {
            if (controller.status.canShowCamera) {
              return controller.cameraController.buildPreview();
            }

            return Container();
          }),
          RotatedBox(
            quarterTurns: 1,
            child: Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black38,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      "Escaneie o código de barras do boleto",
                      style: AppTextStyles.buttonBackground,
                    ),
                    leading: const BackButton(
                      color: AppColors.background,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.black38,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.black38,
                        ),
                      )
                    ],
                  ),
                  bottomNavigationBar: LabelButtonGroup(
                    primaryLabel: "Inserir código do boleto",
                    primaryOnPressed: () {
                      Get.offNamed("/insert_boleto");
                    },
                    secondaryLabel: "Adicionar da galeria",
                    secondaryOnPressed: controller.scanWithImagePicker,
                  ),
                ),
                Obx(() {
                  if (controller.status.hasError) {
                    return BottomSheetWidget(
                      title:
                          "Não foi possível identificar um código de barras.",
                      subtitle:
                          "Tente escanear novamente ou digite o código do seu boleto.",
                      primaryLabel: "Escanear novamente",
                      primaryOnPressed: controller.startImageScan,
                      secondaryLabel: "Digitar código",
                      secondaryOnPressed: () {
                        Get.offNamed("/insert_boleto");
                      },
                    );
                  }

                  return Container();
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
