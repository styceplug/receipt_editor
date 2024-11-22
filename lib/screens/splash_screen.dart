import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:receipt_editor/routes/routes.dart';
import 'package:receipt_editor/utils/app_constants.dart';
import 'package:receipt_editor/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override

  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }

  void initialize(){
    Timer(
      const Duration(seconds: 2),
        ()=>Get.offAllNamed(AppRoutes.homeScreen),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: Dimensions.height240,
          width: Dimensions.width240,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppConstants.getPngAsset('RE_logo'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
