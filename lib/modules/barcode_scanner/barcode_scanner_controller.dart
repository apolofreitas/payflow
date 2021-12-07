import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'barcode_scanner_status.dart';

class BarcodeScannerController extends GetxController {
  late final CameraController cameraController;
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  var isBarcodeScannerProcessingImage = false;
  final _status = BarcodeScannerStatus().obs;
  final void Function(String)? onScanBarcode;

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
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scanBarcodeImage(inputImage);
  }

  void startImageScan() {
    status = BarcodeScannerStatus.available();

    Future.delayed(const Duration(seconds: 30)).then((value) {
      if (status.hasBarcode == false) {
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

        scanBarcodeImage(inputImageCamera);
      } catch (error) {
        status = BarcodeScannerStatus.error(error.toString());
      }
    });
  }

  Future<void> scanBarcodeImage(InputImage inputImage) async {
    if (isBarcodeScannerProcessingImage) return;

    isBarcodeScannerProcessingImage = true;

    try {
      final barcodes = await barcodeScanner.processImage(inputImage);

      String? barcode;

      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.scanned(barcode);
      }
    } catch (error) {
      status = BarcodeScannerStatus.error(error.toString());
    }

    isBarcodeScannerProcessingImage = false;
  }

  @override
  void dispose() {
    barcodeScanner.close();
    if (status.canShowCamera) {
      cameraController.dispose();
    }
    super.dispose();
  }
}
