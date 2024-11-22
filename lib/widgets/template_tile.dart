import 'package:flutter/material.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:receipt_editor/utils/dimensions.dart';

class TemplateTile extends StatelessWidget {
  final AssetImage image;
  final String title;
  final String createdBy;
  final void Function()? onTap;

  const TemplateTile({
    super.key,
    required this.image,
    required this.title,
    required this.createdBy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: Dimensions.width5 / Dimensions.width5, color: Colors.white),
        borderRadius: BorderRadius.circular(Dimensions.radius10),
      ),
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.height10, horizontal: Dimensions.width10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image
          Container(
            height: Dimensions.height100,
            width: Dimensions.width15 * 10,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          //title
          Text(
            title,
            style: TextStyle(
                fontSize: Dimensions.font15,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          //author
          Text(
            'Created by : $createdBy',
            style: TextStyle(fontSize: Dimensions.font10, color: Colors.white),
          ),
          SizedBox(height: Dimensions.height10),
          //btn
          InkWell(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: Dimensions.height40,
              width: Dimensions.width15 * 10,
              decoration: BoxDecoration(
                color: AppColors.color3,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
              child: const Text(
                'Use Template',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
