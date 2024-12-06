import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:receipt_editor/widgets/my_text_field.dart';
import '../../utils/dimensions.dart';
import 'package:path_provider/path_provider.dart';
import '../preview_html_screen.dart';

class YodelForm extends StatefulWidget {
  const YodelForm({super.key});

  @override
  State<YodelForm> createState() => _YodelFormState();
}

class _YodelFormState extends State<YodelForm> {
  // always put your code in this place

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  TextEditingController txnController = TextEditingController();
  TextEditingController parcelIDController = TextEditingController();
  TextEditingController trackingIDController = TextEditingController();

  Future<String> loadTemplate() async {
    /* final file = File('lib/models/template_models/collectplus_model.html');
    return await file.readAsString();*/

    return await rootBundle.loadString('assets/html/yodel_model.html');
  }

  Future<void> generateHtml() async {
    String template = await loadTemplate();
    String generatedHtml = template
        .replaceAll('{{address1}}', address1Controller.text)
        .replaceAll('{{address2}}', address2Controller.text)
        .replaceAll('{{time}}', timeController.text)
        .replaceAll('{{date}}', dateController.text)
        .replaceAll('{{serial_number}}', serialController.text)
        .replaceAll('{{txn}}', txnController.text)
        .replaceAll('{{parcel_id}}', parcelIDController.text)
        .replaceAll('{{tracking_id}}', trackingIDController.text);


    if (kIsWeb) {
      final blob = html.Blob([generatedHtml], 'text/html');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'yodel_receipt.html';
      anchor.click();
      html.Url.revokeObjectUrl(url);
    } else {

      Directory appDocDir = await getApplicationDocumentsDirectory();

      String htmlDirPath = '${appDocDir.path}/assets/html';
      Directory htmlDir = Directory(htmlDirPath);
      if (!htmlDir.existsSync()) {
        await htmlDir.create(recursive: true);
      }

      String filePath = '$htmlDirPath/yodel_receipt.html';
      File file = File(filePath);
      await file.writeAsString(generatedHtml);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PreviewHtmlScreen(filePath: filePath),
        ),
      );
    }

    /*// Directory appDocDir = await getApplicationDocumentsDirectory();
    // String filePath = '${appDocDir.path}/generated_receipt.html';
    // File file = File(filePath);
    // await file.writeAsString(generatedHtml);

    Directory appDocDir = await getApplicationDocumentsDirectory();

    String htmlDirPath = '${appDocDir.path}/assets/html';
    Directory htmlDir = Directory(htmlDirPath);
    if (!htmlDir.existsSync()) {
      await htmlDir.create(recursive: true);
    }

    String filePath = '$htmlDirPath/generated_receipt.html';
    File file = File(filePath);
    await file.writeAsString(generatedHtml);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewHtmlScreen(filePath: filePath),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 1,
        title: const Text('YODEL TEMPLATE'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: Dimensions.font22,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: AppColors.color1,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.height20),
              Text(
                'Fill Input Field',
                style: TextStyle(
                    fontSize: Dimensions.font25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Dimensions.height5,
              ),
              Text(
                'FIll all required field in form below...',
                style: TextStyle(
                    fontSize: Dimensions.font15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: Dimensions.height30),
              MyTextField(
                  labelText: 'Address Line 1',
                  hintText: 'Input Store Location',
                  controller: address1Controller,
                  keyboardType: TextInputType.streetAddress),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Address Line 2',
                  hintText: 'Input Store Location',
                  controller: address2Controller,
                  keyboardType: TextInputType.streetAddress),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Set Time',
                  hintText: 'Input time',
                  controller: timeController,
                  keyboardType: TextInputType.datetime),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Set Date',
                  hintText: 'Input Date',
                  controller: dateController,
                  keyboardType: TextInputType.datetime),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(9)],
                  labelText: 'Input Serial Number',
                  hintText: 'Type Serial Number',
                  controller: serialController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(4)],
                  labelText: 'Set TXN',
                  hintText: 'Input TXN',
                  controller: txnController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Set Parcel ID',
                  hintText: 'Input Parcel ID',
                  controller: parcelIDController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Set Tracking ID',
                  hintText: 'Input Tracking ID',
                  controller: trackingIDController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height40),
              InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  generateHtml();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Dimensions.height50,
                  decoration: BoxDecoration(
                      color: AppColors.color3,
                      borderRadius: BorderRadius.circular(Dimensions.radius20)),
                  child: Text(
                    'Preview Template',
                    style: TextStyle(
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
