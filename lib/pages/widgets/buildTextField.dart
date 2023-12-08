import 'package:flutter/material.dart';

import '../../utils/app_Colors.dart';
import '../../utils/app_Text_style.dart';

Padding buildTextField(Function onTap, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        style: AppTextStyle.kHintTextStyle,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.kFilledColor,
          hintText: 'search Wallpaper',
          hintStyle: AppTextStyle.kHintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              onTap();
            },
            icon: Icon(
              Icons.search,
              color: Colors.black54,
              size: 25,
            ),
          ),
        ),
      ),
    ),
  );
}
