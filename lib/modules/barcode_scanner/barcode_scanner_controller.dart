import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'barcode_scanner_status.dart';

class BarcodeScannerController extends GetxController {
  late final CameraController cameraController;
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  var isBarcodeScannerProcessingImage = false;
  final _status = BarcodeScannerStatus().obs;
  final void Function(String)? onScanBarcode;
  var isDisposed = false;

  BarcodeScannerStatus get status => _status.value;
  set status(BarcodeScannerStatus status) => _status.value = status;

  BarcodeScannerController({this.onScanBarcode}) {
    _status.listen((status) async {
      if (status.hasError) {
        log(
          'Caught error in barcode scanner',
          name: 'BarcodeScannerController',
          error: status.error,
        );
      }

      if (status.stopScanner) {
        await barcodeScanner.close();
      }

      if (status.hasBarcode) {
        cameraController.dispose();
        if (onScanBarcode != null) onScanBarcode!(status.barcode);
      }
    });
  }

  void initialize() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );

      cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController.initialize();
      startListeningToCamera();
      startImageScan();
    } catch (error) {
      status = BarcodeScannerStatus.error(error.toString());
    }
  }

  void scanWithImagePicker() async {
    try {
      final response =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (response == null) return;
      final inputImage = InputImage.fromFilePath(response.path);
      await scanBarcodeImage(inputImage);
      if (status.barcode.isEmpty) {
        Get.showSnackbar(
          GetSnackBar(
            messageText: Text(
              "Não foi possível reconhecer nenhum código de barras",
              style: AppTextStyles.buttonBackground,
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (error) {
      status = BarcodeScannerStatus.error(error.toString());
    }
  }

  void startImageScan() {
    status = BarcodeScannerStatus.available();

    Future.delayed(const Duration(seconds: 30)).then((value) {
      if (status.hasBarcode == false && !isDisposed) {
        status = BarcodeScannerStatus.error("Scanning barcode timeout");
      }
    });
  }

  void startListeningToCamera() {
    if (cameraController.value.isStreamingImages) return;

    cameraController.startImageStream((cameraImage) async {
      if (status.stopScanner == true) return;

      try {
        final allBytes = WriteBuffer();

        for (final plane in cameraImage.planes) {
          allBytes.putUint8List(plane.bytes);
        }

        final bytes = allBytes.done().buffer.asUint8List();

        final imageSize = Size(
          cameraImage.width.toDouble(),
          cameraImage.height.toDouble(),
        );

        const imageRotation = InputImageRotation.Rotation_0deg;

        final inputImageFormat =
            InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
                InputImageFormat.NV21;

        final planeData = cameraImage.planes.map(
          (plane) {
            return InputImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            );
          },
        ).toList();

        final inputImageData = InputImageData(
          size: imageSize,
          imageRotation: imageRotation,
          inputImageFormat: inputImageFormat,
          planeData: planeData,
        );

        final inputImageCamera = InputImage.fromBytes(
          bytes: bytes,
          inputImageData: inputImageData,
        );

        if (!isBarcodeScannerProcessingImage) {
          scanBarcodeImage(inputImageCamera);
        }
      } catch (error) {
        status = BarcodeScannerStatus.error(error.toString());
      }
    });
  }

  Future<void> scanBarcodeImage(InputImage inputImage) async {
    isBarcodeScannerProcessingImage = true;

    final barcodes = await barcodeScanner.processImage(inputImage);

    String? barcode;

    for (Barcode item in barcodes) {
      barcode = item.value.displayValue;
    }

    if (barcode != null && status.barcode.isEmpty) {
      status = BarcodeScannerStatus.scanned(barcode);
    }

    isBarcodeScannerProcessingImage = false;
  }

  @override
  void dispose() {
    isDisposed = true;
    barcodeScanner.close();
    if (status.canShowCamera) {
      cameraController.dispose();
    }
    super.dispose();
  }
}
