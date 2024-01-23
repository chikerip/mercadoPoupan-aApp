// ignore_for_file: file_names, camel_case_types, unnecessary_cast
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mercadopoupanca/components/AppAdvertsBar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class barcodeScan extends StatefulWidget {
  const barcodeScan({super.key});

  @override
  State<barcodeScan> createState() => _barcodeScan();
}

class _barcodeScan extends State<barcodeScan> {
  final _localStorage = Hive.box('localStorage');
  MobileScannerController cameraController = MobileScannerController();
  bool scanned = false;

  @override
  void initState() {
    super.initState();
    _localStorage.put('scanned', false);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        MobileScanner(
          // fit: BoxFit.contain,
          controller: cameraController,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              if (_localStorage.get('scanned') == false) {
                _localStorage.put('scanned', true);
                Navigator.of(context).pushReplacementNamed('/product',
                    arguments: barcode.rawValue!.toString());
              }
            }
          },
        ),
        Stack(
          children: [
            Positioned(
              top: screenheight * 0.4,
              left: 0,
              child: Container(
                height: screenheight * 0.2,
                width: screenWidth * 0.1,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            Positioned(
              top: screenheight * 0.4,
              right: 0,
              child: Container(
                height: screenheight * 0.2,
                width: screenWidth * 0.1,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: screenheight * 0.4,
                width: screenWidth,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: screenheight * 0.4,
                width: screenWidth,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
          ],
        ),
        Positioned(
          top: screenheight * 0.4,
          right: screenWidth * 0.1,
          child: Container(
            width: screenWidth * 0.8,
            height: screenheight * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Colors.white, width: screenWidth * 0.01),
            ),
          ),
        ),
        const Positioned(
          top: 0,
          child: AppAdvertsBar(),
        ),
        Positioned(
            top: screenheight * 0.1,
            // ignore: sized_box_for_whitespace
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.02, 0, screenWidth * 0.02, 0),
              margin: EdgeInsets.fromLTRB(
                  screenWidth * 0.02, 0, screenWidth * 0.02, 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              width: screenWidth * 0.95,
              height: screenheight * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: const Icon(Icons.arrow_back_ios)),
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.torchState,
                      builder: (context, state, child) {
                        switch (state as TorchState) {
                          case TorchState.off:
                            return const Icon(Icons.flash_off,
                                color: Colors.black);
                          case TorchState.on:
                            return const Icon(Icons.flash_on,
                                color: Colors.yellow);
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => cameraController.toggleTorch(),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.cameraFacingState,
                      builder: (context, state, child) {
                        switch (state as CameraFacing) {
                          case CameraFacing.front:
                            return const Icon(Icons.camera_front,
                                color: Colors.black);
                          case CameraFacing.back:
                            return const Icon(Icons.camera_rear,
                                color: Colors.black);
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => cameraController.switchCamera(),
                  ),
                ],
              ),
            ))
      ]),
    );
  }
}
