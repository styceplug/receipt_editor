import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/my_text_field.dart';
import '../preview_html_screen.dart';

class DpdForm extends StatefulWidget {
  const DpdForm({super.key});

  @override
  State<DpdForm> createState() => _DpdFormState();
}

TextEditingController locationController = TextEditingController();
TextEditingController timeController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController serialController = TextEditingController();
TextEditingController txnController = TextEditingController();
TextEditingController panelIDController = TextEditingController();
TextEditingController trackingIDController = TextEditingController();

class _DpdFormState extends State<DpdForm> {
  Future<String> loadTemplate() async {
    return await rootBundle.loadString('assets/html/dpd_model.html');
  }

  Future<void> generateHtml() async {
    String template = await loadTemplate();
    String generatedHtml = template
        .replaceAll('{{store_location}}', locationController.text)
        .replaceAll('{{time}}', timeController.text)
        .replaceAll('{{date}}', dateController.text)
        .replaceAll('{{serial_number}}', serialController.text)
        .replaceAll('{{txn}}', txnController.text)
        .replaceAll('{{parcel_id}}', panelIDController.text)
        .replaceAll('{{tracking_id}}', trackingIDController.text);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/generated_receipt.html';
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
        title: const Text('COLLECT+ TEMPLATE'),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.font22,
            fontWeight: FontWeight.w400),
      ),
      backgroundColor: AppColors.color1,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimensions.height20),
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
                  labelText: 'Store Location',
                  hintText: 'Input Store Location',
                  controller: locationController,
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
                  labelText: 'Input Serial Number',
                  hintText: 'Type Serial Number',
                  controller: serialController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Set TXN',
                  hintText: 'Input TXN',
                  controller: txnController,
                  keyboardType: TextInputType.number),
              SizedBox(height: Dimensions.height10),
              MyTextField(
                  labelText: 'Set Parcel ID',
                  hintText: 'Input Parcel ID',
                  controller: panelIDController,
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
