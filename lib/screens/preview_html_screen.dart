import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:receipt_editor/helpers/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';



import '../utils/colors.dart';
import '../utils/dimensions.dart';

class PreviewHtmlScreen extends StatefulWidget {
  final String filePath;

  const PreviewHtmlScreen({super.key, required this.filePath});

  @override
  State<PreviewHtmlScreen> createState() => _PreviewHtmlScreenState();
}

class _PreviewHtmlScreenState extends State<PreviewHtmlScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() async {
    final String htmlContent = File(widget.filePath).readAsStringSync();



    final String baseUrl = Platform.isAndroid
        ? 'file:///android_asset/flutter_assets/assets/html/'
        : 'flutter_assets/assets/html/';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.dataFromString(
          htmlContent,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
          parameters: {'baseUrl': baseUrl},
        ),
      );

    var cur = await _controller.currentUrl();
    print(cur);
    print(_controller.toString());
    log(htmlContent);
  }

  Future<Directory> getDownloadsDirectory() async {
    if (Platform.isAndroid) {

      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final downloadsDir = Directory('${directory.path}/Download');
        if (await downloadsDir.exists()) {
          return downloadsDir;
        } else {
          return downloadsDir.create(recursive: true);
        }
      } else {
        throw Exception("Unable to access external storage on this device.");
      }
    } else if (Platform.isIOS) {
      return getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  Future<void> downloadAsPdf(BuildContext context, String filePath) async {
    try {

      bool storageGranted =
      await requestPermission(Permission.manageExternalStorage);
      bool bluetoothGranted = await requestPermission(Permission.bluetoothConnect);

      if (storageGranted && bluetoothGranted) {
        print("All permissions granted!");
      } else {
        print("Some permissions were denied.");
      }

     /* final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Storage permission is required to save the PDF.'),
          ),
        );
        return;
      }*/

      final String htmlContent = await File(filePath).readAsString();

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Text(htmlContent),
        ),
      );

      // Directory downloadsDir;
      // if (Platform.isAndroid) {
      //   downloadsDir = Directory('/storage/emulated/0/Download');
      // } else if (Platform.isIOS) {
      //   downloadsDir = await getApplicationDocumentsDirectory();
      // } else {
      //   throw UnsupportedError('Unsupported platform');
      // }
      //
      // final pdfPath = '${downloadsDir.path}/template_receipt.pdf';
      // final pdfFile = File(pdfPath);
      //
      // await pdfFile.writeAsBytes(await pdf.save());

      Directory downloadsDir = await getDownloadsDirectory();
      final pdfPath = '${downloadsDir.path}/template_receipt.pdf';
      final pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved successfully at: $pdfPath'),
        ),
      );

      await Share.shareXFiles(
        [XFile(pdfFile.path)],
        text: 'Here is the receipt PDF.',
      );
    } catch (e, stacktrace) {
      print('error saving pdf $e stacktrace $stacktrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.filePath);
    return Scaffold(
      appBar: AppBar(title: const Text("Preview HTML")),
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        margin: EdgeInsets.symmetric(
          vertical: Dimensions.height20,
          horizontal: Dimensions.width20,
        ),
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
            InkWell(
              onTap: () {
                downloadAsPdf(context, widget.filePath);
              },
              child: Container(
                alignment: Alignment.center,
                height: Dimensions.height65,
                width: Dimensions.screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.color1,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Text(
                  'Download PDF',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.font18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
