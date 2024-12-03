import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:receipt_editor/widgets/my_text_field.dart';
import '../../utils/dimensions.dart';
import 'package:path_provider/path_provider.dart';
import '../preview_html_screen.dart';

class DpdForm extends StatefulWidget {
  const DpdForm({super.key});

  @override
  State<DpdForm> createState() => _DpdFormState();
}

class _DpdFormState extends State<DpdForm> {
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController tpController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController suController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController fadController = TextEditingController();
  TextEditingController areaCodeController = TextEditingController();
  TextEditingController sessionIdController = TextEditingController();
  TextEditingController txnController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController schemeController = TextEditingController();
  TextEditingController svcController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
  TextEditingController entryController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController productNoController = TextEditingController();
  TextEditingController customerReferenceController = TextEditingController();
  TextEditingController parcelIDController = TextEditingController();

  Future<String> loadTemplate() async {
    /* final file = File('lib/models/template_models/collectplus_model.html');
    return await file.readAsString();*/

    return await rootBundle.loadString('assets/html/dpd_model.html');
  }

  Future<void> generateHtml() async {
    String template = await loadTemplate();
    String generatedHtml = template
        .replaceAll('{{address1}}', address1Controller.text)
        .replaceAll('{{address2}}', address2Controller.text)
        .replaceAll('{{address3}}', address3Controller.text)
        .replaceAll('{{time}}', timeController.text)
        .replaceAll('{{date}}', dateController.text)
        .replaceAll('{{tp}}', tpController.text)
        .replaceAll('{{bp}}', bpController.text)
        .replaceAll('{{su}}', suController.text)
        .replaceAll('{{fad}}', fadController.text)
        .replaceAll('{{area_code}}', areaCodeController.text)
        .replaceAll('{{session_id}}', sessionIdController.text)
        .replaceAll('{{txn}}', txnController.text)
        .replaceAll('{{client}}', clientController.text)
        .replaceAll('{{scheme}}', schemeController.text)
        .replaceAll('{{svc}}', svcController.text)
        .replaceAll('{{token}}', tokenController.text)
        .replaceAll('{{entry}}', entryController.text)
        .replaceAll('{{reference}}', referenceController.text)
        .replaceAll('{{amount}}', amountController.text)
        .replaceAll('{{product_no}}', productNoController.text)
        .replaceAll('{{customer_reference}}', customerReferenceController.text)
        .replaceAll('{{parcel_id}}', parcelIDController.text);

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
        title: const Text('DPD TEMPLATE'),
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
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(2)],
                        labelText: 'Tp Number',
                        hintText: 'Type TP Number',
                        controller: tpController,
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(2)],
                        labelText: 'BP Number',
                        hintText: 'Type BP Number',
                        controller: bpController,
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(2)],
                        labelText: 'SU Number',
                        hintText: 'Type SU Number',
                        controller: suController,
                        keyboardType: TextInputType.text),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(7)],
                        labelText: 'Set FAD',
                        hintText: 'Input FAD',
                        controller: fadController,
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        labelText: 'Set Session ID',
                        hintText: 'Input Session ID',
                        controller: sessionIdController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true)),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(1)],
                  labelText: 'Set Txn ID',
                  hintText: 'Input Txn ID',
                  controller: txnController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  // inputFormatter: [LengthLimitingTextInputFormatter(1)],
                  labelText: 'Input Client',
                  hintText: 'Input Client',
                  controller: clientController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  // inputFormatter: [LengthLimitingTextInputFormatter(1)],
                  labelText: 'Input Scheme',
                  hintText: 'Input Scheme',
                  controller: schemeController,
                  keyboardType: TextInputType.text),
              SizedBox(height: Dimensions.height10),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(2)],
                        labelText: 'Input Token Type',
                        hintText: 'Type Token Type',
                        controller: tokenController,
                        keyboardType: TextInputType.text),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(1)],
                        labelText: 'Input Entry',
                        hintText: 'Input Entry',
                        controller: entryController,
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(14)],
                  labelText: 'Input Ref',
                  hintText: 'Type Ref',
                  controller: referenceController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(2)],
                  labelText: 'Input Svc',
                  hintText: 'Type Svc',
                  controller: svcController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              SizedBox(height: Dimensions.height10),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        // inputFormatter: [LengthLimitingTextInputFormatter(1)],
                        labelText: 'Input Amount',
                        hintText: 'Set Amount',
                        controller: amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true)),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(5)],
                        labelText: 'Input Product No',
                        hintText: 'Input Product No',
                        controller: productNoController,
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(9)],
                  labelText: 'Input Customer Reference',
                  hintText: 'Input Customer Reference',
                  controller: customerReferenceController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  inputFormatter: [LengthLimitingTextInputFormatter(14)],
                  labelText: 'Input Parcel ID',
                  hintText: 'Input Parcel ID',
                  controller: parcelIDController,
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
              ),
              SizedBox(height: Dimensions.height40)
            ],
          ),
        ),
      ),
    );
  }
}
