import 'package:flutter/material.dart';
import 'package:receipt_editor/utils/dimensions.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final void Function()? onTap;

  const DrawerTile(
      {super.key,
      required this.title,
      required this.leading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height10),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: Dimensions.font18,
              fontWeight: FontWeight.w500,
              color:Colors.black),
        ),
        leading: leading,
        onTap: onTap,
      ),
    );
  }
}
