import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_to_pdf/html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:receipt_editor/helpers/html_helper.dart' as html;

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
  late String htmlContent;

  @override
  void initState() {
    super.initState();
      _initializeMobilePreview();
  }

 /* void _initializeWebPreview(){
    htmlContent = File(widget.filePath).readAsStringSync();
    log(htmlContent);
  }*/

  void _initializeMobilePreview() async {
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
    /*if (kIsWeb) {
      throw UnsupportedError('Download directory is not supported on web');
    }*/
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
      final String htmlContent = await File(filePath).readAsString();

      /*if (kIsWeb) {
        final blob = html.Blob([htmlContent], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'template_receipt.pdf')
          ..click();
        html.Url.revokeObjectUrl(url);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF ready for download')),
        );
        return;
      }*/

      bool permissionGranted = await requestStoragePermission();
      if (!permissionGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Storage permission is required to save the PDF.'),
          ),
        );
        return;
      }



      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String pdfFileName = "template_receipt";

      final pdfFile = await HtmlToPdf.convertFromHtmlContent(
        htmlContent: htmlContent,
        printPdfConfiguration: PrintPdfConfiguration(
          targetDirectory: tempPath,
          targetName: pdfFileName,
          printSize: PrintSize.A4,
          printOrientation: PrintOrientation.Portrait,
        ),
      );

      final pdfFilePath = pdfFile.path;

      await Share.shareXFiles(
        [XFile(pdfFilePath)],
        text: 'Here is the receipt PDF.',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved and ready for sharing: $pdfFilePath'),
        ),
      );
    } catch (e, stacktrace) {
      print('Error generating PDF: $e, stacktrace: $stacktrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving PDF: $e')),
      );
    }
  }

  Future<bool> requestStoragePermission() async {

    if (await Permission.storage.isGranted) {
      return true;
    }

    PermissionStatus status = await Permission.storage.request();

    return status.isGranted;
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
                  'Generate PDF',
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
