import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:receipt_editor/routes/routes.dart';
import 'package:receipt_editor/utils/colors.dart';
import 'package:receipt_editor/utils/dimensions.dart';
import 'package:receipt_editor/widgets/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.color2,
      child: Column(
        children: [
          //header
          DrawerHeader(
            child: Icon(CupertinoIcons.folder_circle_fill,
                color: Colors.black, size: Dimensions.iconSize30),
          ),

          //home tile

          DrawerTile(
            title: 'H O M E',
            leading: const Icon(Iconsax.home_hashtag),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.homeScreen);
            },
          ),

          //template tile

          DrawerTile(
            title: 'T E M P L A T E S',
            leading: const Icon(Iconsax.folder_open),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.templateScreen);
            },
          ),

          //about tile

          DrawerTile(
            title: 'A B O U T  A P P',
            leading: const Icon(Iconsax.info_circle),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.aboutScreen);
            },
          ),
        ],
      ),
    );
  }
}
