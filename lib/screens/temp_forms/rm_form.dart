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

class RmForm extends StatefulWidget {
  const RmForm({super.key});

  @override
  State<RmForm> createState() => _RmFormState();
}

class _RmFormState extends State<RmForm> {
  // always put your code in this place

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController txnController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController collectionController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  TextEditingController tpController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController suController = TextEditingController();
  TextEditingController fadController = TextEditingController();
  TextEditingController sessionIdController = TextEditingController();

  Future<String> loadTemplate() async {
    /* final file = File('lib/models/template_models/collectplus_model.html');
    return await file.readAsString();*/

    return await rootBundle.loadString('assets/html/rm_model.html');
  }

  Future<void> generateHtml() async {
    String template = await loadTemplate();
    String generatedHtml = template
        .replaceAll('{{tp}}', tpController.text)
        .replaceAll('{{bp}}', bpController.text)
        .replaceAll('{{su}}', suController.text)
        .replaceAll('{{fad}}', fadController.text)
        .replaceAll('{{session_id}}', sessionIdController.text)
        .replaceAll('{{time}}', timeController.text)
        .replaceAll('{{date}}', dateController.text)
        .replaceAll('{{address1}}', address1Controller.text)
        .replaceAll('{{address2}}', address2Controller.text)
        .replaceAll('{{address3}}', address3Controller.text)
        .replaceAll('{{post_code}}', postCodeController.text)
        .replaceAll('{{txn}}', txnController.text)
        .replaceAll('{{building_no}}', buildingController.text)
        .replaceAll('{{zip_code}}', zipCodeController.text)
        .replaceAll('{{dest}}', destinationController.text)
        .replaceAll('{{barcode}}', barcodeController.text)
        .replaceAll('{{collection}}', collectionController.text)
        .replaceAll('{{weight}}', weightController.text);


    if (kIsWeb) {
      final blob = html.Blob([generatedHtml], 'text/html');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'rm_receipt.html';
      anchor.click();
      html.Url.revokeObjectUrl(url);
    } else {

      Directory appDocDir = await getApplicationDocumentsDirectory();

      String htmlDirPath = '${appDocDir.path}/assets/html';
      Directory htmlDir = Directory(htmlDirPath);
      if (!htmlDir.existsSync()) {
        await htmlDir.create(recursive: true);
      }

      String filePath = '$htmlDirPath/rm_receipt.html';
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
        title: const Text('RM TEMPLATE'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(2)],
                        labelText: 'TP',
                        hintText: 'Input TP',
                        controller: tpController,
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(2)],
                        labelText: 'Input BP',
                        hintText: 'Input BP',
                        controller: bpController,
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextField(
                        labelText: 'Input SU',
                        hintText: 'Input SU',
                        controller: suController,
                        keyboardType: TextInputType.text),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(7)],
                        labelText: 'Input FAD',
                        hintText: 'Input FAD',
                        controller: fadController,
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Input Session ID',
                  hintText: 'Type Session ID',
                  controller: sessionIdController,
                  keyboardType: TextInputType.numberWithOptions(signed: true)),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Address Line 1',
                  hintText: 'Input Address Line 1',
                  controller: address1Controller,
                  keyboardType: TextInputType.streetAddress),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Address Line 2',
                  hintText: 'Input Address Line 2',
                  controller: address2Controller,
                  keyboardType: TextInputType.streetAddress),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Address Line 3',
                  hintText: 'Input Address Line 3',
                  controller: address3Controller,
                  keyboardType: TextInputType.streetAddress),
              SizedBox(height: Dimensions.height10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextField(
                        labelText: 'Set Time',
                        hintText: 'Input time',
                        controller: timeController,
                        keyboardType: TextInputType.datetime),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        labelText: 'Set Date',
                        hintText: 'Input Date',
                        controller: dateController,
                        keyboardType: TextInputType.datetime),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  // inputFormatter: [LengthLimitingTextInputFormatter(9)],
                  labelText: 'Input Post Code',
                  hintText: 'Type Post Code',
                  controller: postCodeController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(4)],
                  labelText: 'Set TXN',
                  hintText: 'Input TXN',
                  controller: txnController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Building number',
                  hintText: 'Input Building Number',
                  controller: buildingController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: ' Zip Code',
                  hintText: 'Input Zip Code',
                  controller: zipCodeController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Destination',
                  hintText: 'Type Destination here',
                  controller: destinationController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: ' Barcode',
                  hintText: 'Input Barcode',
                  controller: barcodeController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: MyTextField(
                      inputFormatter: [LengthLimitingTextInputFormatter(1)],
                      labelText: 'Posted after Last Collection?',
                      hintText: 'Y or N',
                      controller: collectionController,
                      keyboardType: TextInputType.text)),
                  SizedBox(width: Dimensions.width10),
                  Expanded(child: MyTextField(
                      labelText: 'Weight',
                      hintText: 'Input Weight in g',
                      controller: weightController,
                      keyboardType: TextInputType.number))
                ],
              ),
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
              ),
              SizedBox(height: Dimensions.height40),
            ],
          ),
        ),
      ),
    );
  }
}
