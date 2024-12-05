import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:receipt_editor/widgets/my_text_field.dart';
import '../../utils/dimensions.dart';
import 'package:path_provider/path_provider.dart';
import '../preview_html_screen.dart';

class ParcelForceForm extends StatefulWidget {
  const ParcelForceForm({super.key});

  @override
  State<ParcelForceForm> createState() => _ParcelForceFormState();
}

class _ParcelForceFormState extends State<ParcelForceForm> {
  // always put your code in this place

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController sessionIdController = TextEditingController();
  TextEditingController destController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController expressController = TextEditingController();
  TextEditingController enhancedCompController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController collectionController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController validityController = TextEditingController();

  Future<String> loadTemplate() async {
    /* final file = File('lib/models/template_models/collectplus_model.html');
    return await file.readAsString();*/

    return await rootBundle.loadString('assets/html/parcel_force_model.html');
  }

  Future<void> generateHtml() async {
    String template = await loadTemplate();
    String generatedHtml = template
        .replaceAll('{{address1}}', address1Controller.text)
        .replaceAll('{{address2}}', address2Controller.text)
        .replaceAll('{{address3}}', address3Controller.text)
        .replaceAll('{{area_code}}', areaController.text)
        .replaceAll('{{time}}', timeController.text)
        .replaceAll('{{date}}', dateController.text)
        .replaceAll('{{session_id}}', sessionIdController.text)
        .replaceAll('{{destination}}', destController.text)
        .replaceAll('{{quantity}}', quantityController.text)
        .replaceAll('{{weight}}', weightController.text)
        .replaceAll('{{express}}', expressController.text)
        .replaceAll('{{enhanced_comp}}', enhancedCompController.text)
        .replaceAll('{{cost}}', amountController.text)
        .replaceAll('{{collection}}', collectionController.text)
        .replaceAll('{{condition}}', conditionController.text)
        .replaceAll('{{barcode}}', barcodeController.text)
        .replaceAll('{{building_no}}', buildingController.text)
        .replaceAll('{{postcode}}', postCodeController.text)
        .replaceAll('{{validated}}', validityController.text);

    // Directory appDocDir = await getApplicationDocumentsDirectory();
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 1,
        title: const Text('PARCEL FORCE TEMPLATE'),
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
              MyTextField(
                  labelText: 'Set Area Code',
                  hintText: 'Input Area Code',
                  controller: areaController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              Row(
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
                  inputFormatter: [LengthLimitingTextInputFormatter(11)],
                  labelText: 'Input Session ID',
                  hintText: 'Type Session ID',
                  controller: sessionIdController,
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true)),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  // inputFormatter: [LengthLimitingTextInputFormatter(2)],
                  labelText: 'Input Package Destination',
                  hintText: 'Type Package Destination',
                  controller: destController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(4)],
                        labelText: 'Input Quantity',
                        hintText: 'Product Quantity',
                        controller: quantityController,
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(7)],
                        labelText: 'Input Weight',
                        hintText: 'Provide weight in KG',
                        controller: weightController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        labelText: 'Express Price',
                        hintText: 'Price in £',
                        controller: expressController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true)),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        // inputFormatter: [LengthLimitingTextInputFormatter()],
                        labelText: 'Enhanced Comp',
                        hintText: 'Input Enhanced Comp in £',
                        controller: enhancedCompController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  // inputFormatter: [LengthLimitingTextInputFormatter(1)],
                  labelText: 'Total Cost of Service',
                  hintText: 'Input Total Cost in £',
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(3)],
                  labelText: 'Posted after last Collection?',
                  hintText: 'Yes or No?',
                  controller: collectionController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(3)],
                  labelText: 'Condition Accepted?',
                  hintText: 'Yes or No?',
                  controller: conditionController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(13)],
                  labelText: 'Input Barcode text',
                  hintText: 'Type Barcode text ',
                  controller: barcodeController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(2)],
                  labelText: 'Building number',
                  hintText: 'Input Building number',
                  controller: buildingController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(9)],
                  labelText: 'Input Postcode',
                  hintText: 'Provide Postcode',
                  controller: postCodeController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(1)],
                  labelText: 'Address Validated?',
                  hintText: 'Y or N?',
                  controller: validityController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true)),
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
              SizedBox(height: Dimensions.height40)
            ],
          ),
        ),
      ),
    );
  }
}
