import 'package:flutter/material.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:receipt_editor/widgets/drawer.dart';

import '../../utils/dimensions.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('A B O U T  A P P'),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.font22,
            fontWeight: FontWeight.w400),
      ),
      drawer: const MyDrawer(),
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        margin: EdgeInsets.symmetric(
            vertical: Dimensions.height40, horizontal: Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Receipts Editor',
              style: TextStyle(
                  fontSize: Dimensions.font25,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Text(
              'Our app provides a fast, easy way to customize ready-made receipt and ticket templates, designed ',
              style: TextStyle(
                  fontSize: Dimensions.font15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Text(
              'for businesses and individuals alike. Whether you are creating invoices, event tickets, or custom receipts, our intuitive editing tools help you produce ',
              style: TextStyle(
                  fontSize: Dimensions.font15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Text(
              'professional, personalized documents in minutes. With a range of templates and customization options, you can adjust text, dates, logos, and styles to fit your specific needs. Perfect for on-the-go ',
              style: TextStyle(
                  fontSize: Dimensions.font15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Text(
              'adjustments, this app is designed to be user-friendly, secure, and efficient, making document creation a seamless part of your workflow. Let us help you streamline your paperwork and enhance your brand image with polished, custom receipts and tickets that impress!',
              style: TextStyle(
                  fontSize: Dimensions.font15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            SizedBox(height: Dimensions.height50),
            Text(
              textAlign: TextAlign.center,
              '❖ Designed and Developed by S T Y C E 🩷❤️🧡 ❖',
              style: TextStyle(
                  fontSize: Dimensions.font15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
