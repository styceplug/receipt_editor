import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:receipt_editor/routes/routes.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:receipt_editor/widgets/drawer.dart';
import 'package:receipt_editor/widgets/template_tile.dart';

import '../../utils/dimensions.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color1,
      appBar: AppBar(
        backgroundColor: AppColors.color1,
        foregroundColor: Colors.white,
        title: const Text('T E M P L A T E S'),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.font22,
            fontWeight: FontWeight.w400),
      ),
      drawer: const MyDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.width20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Browse Collections',
                style: TextStyle(
                    fontSize: Dimensions.font25,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: Dimensions.height5,
              ),
              Text(
                'Browse through our wide range of templates and select best fit for your project...',
                style: TextStyle(
                    fontSize: Dimensions.font15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: Dimensions.height50),
              Row(
                children: [
                  Text(
                    'Templates',
                    style: TextStyle(
                        fontSize: Dimensions.font18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: Dimensions.width5),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: Dimensions.iconSize16,
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: Dimensions.height20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TemplateTile(
                          image: const AssetImage('assets/images/Collect+.png'),
                          title: "Collect+ Template",
                          onTap: () {
                            Get.toNamed(AppRoutes.collectPlusForm);
                          },
                          createdBy: 'Admin'),
                      TemplateTile(
                          image: const AssetImage('assets/images/Collect+_A4.png'),
                          title: 'Collect+ A4 Template',
                          createdBy: 'Author',
                          onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TemplateTile(
                          image: const AssetImage('assets/images/DPD.png'),
                          title: "DPD Template",
                          onTap: () {},
                          createdBy: 'Admin'),
                      TemplateTile(
                          image: const AssetImage('assets/images/Parcelforce.png'),
                          title: 'Parcelforce Template',
                          createdBy: 'Author',
                          onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TemplateTile(
                          image: const AssetImage('assets/images/RM.png'),
                          title: "RM Template",
                          onTap: () {},
                          createdBy: 'Admin'),
                      TemplateTile(
                          image: const AssetImage('assets/images/YodelA4.png'),
                          title: 'YodelA4 Template',
                          createdBy: 'Author',
                          onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Dimensions.height20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
