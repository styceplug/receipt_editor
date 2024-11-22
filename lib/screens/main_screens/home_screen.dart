import 'package:flutter/material.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:receipt_editor/utils/dimensions.dart';
import 'package:receipt_editor/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color1,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: const Text('H O M E'),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.font22,
            fontWeight: FontWeight.w400),
      ),
      drawer: const MyDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.width20, vertical: Dimensions.height30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Receipt Editor',
              style: TextStyle(
                  fontSize: Dimensions.font25,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: Dimensions.height5,
            ),
            Text(
              'Explore app, select Templates, Fill input fields, preview template, download PDF',
              style: TextStyle(
                  fontSize: Dimensions.font15,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: Dimensions.height50),
            Row(
              children: [
                Text(
                  'History',
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
          ],
        ),
      ),
    );
  }
}
