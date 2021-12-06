import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  final bool isAvailable;
  final bool stopScanner;
  final String barcode;
  final String error;

  BarcodeScannerStatus({
    this.isAvailable = false,
    this.stopScanner = false,
    this.barcode = "",
    this.error = "",
  });

  factory BarcodeScannerStatus.available() => BarcodeScannerStatus(
        isAvailable: true,
        stopScanner: false,
      );

  factory BarcodeScannerStatus.scanned(String barcode) => BarcodeScannerStatus(
        barcode: barcode,
        stopScanner: true,
      );

  factory BarcodeScannerStatus.error(String message) => BarcodeScannerStatus(
        error: message,
        stopScanner: true,
      );

  bool get canShowCamera => isAvailable;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;

  BarcodeScannerStatus copyWith({
    bool? isAvailable,
    String? error,
    String? barcode,
    bool? stopScanner,
    CameraController? cameraController,
  }) {
    return BarcodeScannerStatus(
      isAvailable: isAvailable ?? this.isAvailable,
      error: error ?? this.error,
      barcode: barcode ?? this.barcode,
      stopScanner: stopScanner ?? this.stopScanner,
    );
  }
}
