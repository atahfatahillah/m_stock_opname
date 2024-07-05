import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:m_stock_opname/routers/router_utils.dart';
import 'package:m_stock_opname/services/app_db.dart';
import 'package:m_stock_opname/utils/locator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final database = locator<AppDB>();
  late MobileScannerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final item =
                database.itemsDao.findItemsByCode(barcode.rawValue.toString());
            item.first.then((value) {
              debugPrint(value?.code);
              _controller.dispose();
              _controller.stop();
              context.goNamed(APP_PAGE.itemDetailScreen.routeName,
                  pathParameters: {'code': value?.code ?? ""});
            });
          }
        },
      ),
    );
  }
}
