

import 'package:flutter/material.dart';

import '../../utils/app_Text_style.dart';

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Wallpaper',style:AppTextStyle.kWallPaperStyle,),
        Text('Hub',style: AppTextStyle.kHubStyle,),
      ],
    ),
  );
}
