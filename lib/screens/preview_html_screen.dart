import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
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

  void _initializeWebView() {
    final String htmlContent = File(widget.filePath).readAsStringSync();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.dataFromString(
          htmlContent,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ),
      );
  }

  Future<void> downloadAsPdf(BuildContext context, String filePath) async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Storage permission is required to save the PDF.')),
        );
        return;
      }

      // Read HTML content from file
      final String htmlContent = await File(filePath).readAsString();

      // Create PDF document
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Text(htmlContent),
        ),
      );

      // Determine the download directory
      Directory downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadsDir = await getApplicationDocumentsDirectory();
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      // Save PDF to the determined directory
      final pdfPath = '${downloadsDir.path}/template_receipt.pdf';
      final pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(await pdf.save());

      // Notify user of successful save
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved successfully at: $pdfPath'),
        ),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
